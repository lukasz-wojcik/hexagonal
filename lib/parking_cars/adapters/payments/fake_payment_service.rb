# frozen_string_literal: true

module ParkingCars
  module Adapters
    module Payments
      class FakePaymentService
        Result = Struct.new(:success?, keyword_init: true)

        def process_payment(amount:, payment_data:)
          return Result.new(success?: true) if amount.positive? && payment_data.present?

          raise 'Invalid payment_data or amount'
        end
      end
    end
  end
end
