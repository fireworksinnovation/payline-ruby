module Payline
  class Error < StandardError

    def initialize(message, result = {})
      super(message)
      @result = result
    end

    def result
      @result
    end
  end
end
