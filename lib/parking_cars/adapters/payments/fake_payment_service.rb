# frozen_string_literal: true

module ParkingCars
  module Adapters
    module Payments
      class FakePaymentService
        Result = Struct.new(:'success?', keyword_init: true)

        def process_payment(amount:, payment_data:)
          raise('Invalid payment_data or amount') if amount.positive? && payment_data.present?

          Result.new(success?: true)
        end
      end
    end
  end
end
