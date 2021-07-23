# frozen_string_literal: true

module ParkingCars
  module Adapters
    module Payments
      class FakePaymentService
        Result = Struct.new(:'success?', keyword_init: true)

        def process_payment(amount:, payment_data:)
          Result.new(success?: true)
        end
      end
    end
  end
end
