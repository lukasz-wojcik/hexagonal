module Adapters
  class FakePaymentService
    Result = Struct.new(:'success?', keyword_init: true)

    def process_payment(_payment_data)
      Result.new(success?: true)
    end

  end
end
