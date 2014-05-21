require 'spec_helper'

describe Payline::ResponseHandler do
  before do
    @response = Payline::ResponseHandler.new
  end

  it 'Can parse out text' do
    data = "PROCESSING.RISK_SCORE=0&P3.VALIDATION=ACK&CLEARING.DESCRIPTOR=7092.5040.4626&TRANSACTION.CHANNEL=8a8394c3461960d701461ac26f1c071f&PROCESSING.REASON.CODE=00&ADDRESS.CITY=na&PROCESSING.CODE=CC.PA.90.00&FRONTEND.REQUEST.CANCELLED=false&PROCESSING.REASON=Successful+Processing&FRONTEND.MODE=DEFAULT&CLEARING.FXSOURCE=INTERN&CLEARING.AMOUNT=1.00&PROCESSING.RESULT=ACK&NAME.SALUTATION=NONE&POST.VALIDATION=ACK&CONTACT.EMAIL=test%40test.com&CLEARING.CURRENCY=ZAR&FRONTEND.SESSION_ID=&PROCESSING.STATUS.CODE=90&PRESENTATION.CURRENCY=ZAR&PAYMENT.CODE=CC.PA&PROCESSING.RETURN.CODE=000.100.110&CONTACT.IP=10.3.20.38&PROCESSING.STATUS=NEW&FRONTEND.CC_LOGO=images%2Fvisa_mc.gif&PRESENTATION.AMOUNT=1.00&IDENTIFICATION.UNIQUEID=8a839482461e719d01461eb59f784012&IDENTIFICATION.SHORTID=7092.5040.4626&CLEARING.FXRATE=1.0&PROCESSING.TIMESTAMP=2014-05-21+12%3A15%3A57&ADDRESS.COUNTRY=ZA&ADDRESS.STATE=na&RESPONSE.VERSION=1.0&TRANSACTION.MODE=INTEGRATOR_TEST&TRANSACTION.RESPONSE=SYNC&PROCESSING.RETURN=Request+successfully+processed+in+%27Merchant+in+Integrator+Test+Mode%27&ADDRESS.STREET=na&CLEARING.FXDATE=2014-05-21+12%3A15%3A57&ADDRESS.ZIP=na\r\n"
    hash = @response.parse(data)
    hash['PROCESSING.REASON.CODE'].should eq('00')
    hash['PROCESSING.RISK_SCORE'].should eq('0')
    hash['P3.VALIDATION'].should eq('ACK')
    hash['FRONTEND.REQUEST.CANCELLED'].should eq('false')
  end

  it 'Can handle errors' do
    hash = {
      'PROCESSING.REASON.CODE'=> '1234',
      'PROCESSING.RETURN'=> 'This is the error'
    }
    expect{@response.handle_errors(hash)}.to raise_error(Payline::Error)
    expect{@response.handle_errors(hash)}.to raise_error('This is the error')
  end

   it 'Can deal with success' do
    hash = {
      'PROCESSING.REASON.CODE'=> '00',
      'PROCESSING.RETURN'=> 'Successful'
    }
    @response.handle_errors(hash)
  end

  it 'Parses and checks' do
    data = 'PROCESSING.REASON.CODE=00&PROCESSING.RETURN=Successful&NOMATTER=nomatter'
    hash = @response.parse_and_handle_errors(data)
    hash['NOMATTER'].should eq('nomatter')
  end
end
