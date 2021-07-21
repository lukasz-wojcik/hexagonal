require 'securerandom'

module ParkingCars
  module Services
    class IssuePermit
      def initialize(repository: nil, payment_service: nil, rates_service:)
        self.repository = repository || ApplicationConfig.permits_repository
        self.payment_service = payment_service || ApplicationConfig.payment_service
        self.rates_service = rates_service
      end

      def issue_permit(permit_request)
        rate_name = permit_request.fetch(:rate_name)
        rate = rates_service.get_rate_by_name(rate_name)
        duration = permit_request.fetch(:duration)
        raise "Cannot park in #{rate_name} for so long" unless rate.allowed_duration?(duration)
        price = rate.price_for_duration(duration)
        payment_processing_result = payment_service.process_payment(amount: price, payment_data: permit_request.fetch(:payment_data))
        if payment_processing_result.success?
          repository.create(
            {
              code: SecureRandom.uuid,
              rate_name: rate_name,
              plate_number: permit_request.fetch(:plate_number),
              start_date: DateTime.now,
              end_date: DateTime.now + duration.minutes
            }
          )
        end
      end

      private

      attr_accessor :repository, :payment_service, :rates_service
    end
  end
end
