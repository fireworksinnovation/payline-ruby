module Payline
  class ReserveResponse
    attr_reader :merchant_reference
    attr_reader :transaction_id

    def initialize(merchant_reference, transaction_id)
      @merchant_reference = merchant_reference
      @transaction_id = transaction_id
    end
  end
end
