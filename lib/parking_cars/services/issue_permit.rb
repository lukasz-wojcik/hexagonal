# frozen_string_literal: true

require 'securerandom'

module ParkingCars
  module Services
    class IssuePermit
      def initialize(rates_service:, repository: nil, payment_service: nil)
        self.repository = repository || ApplicationConfig.permits_repository
        self.payment_service = payment_service || ApplicationConfig.payment_service
        self.rates_service = rates_service
      end

      def issue_permit(permit_request)
        rate_name, duration, payment_data, plate_number = *permit_request.slice(:rate_name,
                                                                                :duration,
                                                                                :payment_data,
                                                                                :plate_number).values
        rate = rates_service.rate_by_name(rate_name)
        raise "Cannot park in #{rate_name} for so long" unless rate.allowed_duration?(duration)

        payment_processing_result = collect_payment(duration, payment_data, rate)

        return unless payment_processing_result.success?

        crate_permit_record(duration, plate_number, rate_name)
      end

      private

      def collect_payment(duration, payment_data, rate)
        payment_service.process_payment(amount: rate.price_for_duration(duration), payment_data: payment_data)
      end

      def crate_permit_record(duration, plate_number, rate_name)
        repository.create(
          {
            code: SecureRandom.uuid,
            rate_name: rate_name,
            plate_number: plate_number,
            start_date: DateTime.now,
            end_date: DateTime.now + duration.minutes
          }
        )
      end

      attr_accessor :repository, :payment_service, :rates_service
    end
  end
end
