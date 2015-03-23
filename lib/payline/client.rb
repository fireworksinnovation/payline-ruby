module Payline
  class Client

    def initialize(config)
      @config = config
      @response_handler = Payline::ResponseHandler.new
    end

    def debit(guid, amount, credit_card)
      proccess("CC.DB", guid, amount, credit_card)
    end

    def reserve(guid, amount, credit_card)
      proccess("CC.PA", guid, amount, credit_card)
    end

    def capture(reserve_response, amount)
      params = {
          'PRESENTATION.CURRENCY' => @config.currency,
          'PAYMENT.CODE' => "CC.CP",
          'PRESENTATION.AMOUNT' => amount,
          'IDENTIFICATION.TRANSACTIONID'=>reserve_response.merchant_reference,
          'IDENTIFICATION.REFERENCEID'=> reserve_response.transaction_id
      }
      do_request(params)
    end


    def reverse(reserve_response, amount)
      params = {
          'PRESENTATION.CURRENCY' => @config.currency,
          'PAYMENT.CODE' => "CC.RV",
          'PRESENTATION.AMOUNT' => amount,
          'IDENTIFICATION.TRANSACTIONID'=> reserve_response.merchant_reference,
          'IDENTIFICATION.REFERENCEID'=> reserve_response.transaction_id
      }
      do_request(params)
    end

    private

    def proccess(code, guid, amount, credit_card)
      params = {
          'PAYMENT.CODE' => code,
          'PRESENTATION.AMOUNT' => amount,
          'PRESENTATION.CURRENCY' => @config.currency,

          'ACCOUNT.BRAND' => credit_card[:account_type],
          'ACCOUNT.NUMBER' => credit_card[:card_number],
          'ACCOUNT.EXPIRY_MONTH' => credit_card[:expiry_month],
          'ACCOUNT.EXPIRY_YEAR' => credit_card[:expiry_year],
          'ACCOUNT.HOLDER' => credit_card[:card_holder],
          'ACCOUNT.VERIFICATION' => credit_card[:cvv],

          'NAME.COMPANY' => @config.company_name,
          'CONTACT.EMAIL' => @config.contact_email,

          # need to be here but currently not being passed in
          'ADDRESS.STREET' => 'na',
          'ADDRESS.ZIP' => 'na',
          'ADDRESS.CITY' => 'na',
          'ADDRESS.STATE' => 'na',
          'ADDRESS.COUNTRY' => 'ZA',

          'IDENTIFICATION.TRANSACTIONID' => guid
      }
      hash = do_request(params)
      merchant_id = hash['IDENTIFICATION.TRANSACTIONID']
      ref_id = hash['IDENTIFICATION.UNIQUEID']
      Payline::ReserveResponse.new(merchant_id, ref_id)
    end

    def do_request(params)
      uri = URI(Payline::Urls::PAYMENT)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.path)
      request_data = params.merge(basic_auth)
      req.set_form_data(request_data)
      res = http.request(req)
      hash = @response_handler.parse_and_handle_errors(res.body)
      hash
    end

    def basic_auth
      {
        'SECURITY.SENDER' => @config.sender,
        'TRANSACTION.CHANNEL' => @config.channel,
        'TRANSACTION.MODE' => @config.transaction_mode,
        'USER.LOGIN' => @config.user_login,
        'USER.PWD' => @config.user_password,
        'TRANSACTION.RESPONSE'=>'SYNC'
      }
    end

  end
 end
