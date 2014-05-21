module Payline
  class Configuration
    attr_accessor :sender
    attr_accessor :user_login
    attr_accessor :user_password
    attr_accessor :secret
    attr_accessor :transaction_mode
    attr_accessor :channel
    attr_accessor :currency
    attr_accessor :company_name
    attr_accessor :contact_email

    def initialize
      @currency = "ZAR"
    end
  end
end
