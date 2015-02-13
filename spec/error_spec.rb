require 'spec_helper'

describe Payline::Error do

  it 'Returns error object' do
    a = Payline::Error.new("message", {result: '123', testing:'199'})
    a.message.should eq("message")
    a.result.should eq({result: '123', testing:'199'})
  end

  it 'Returns error object' do
    a = Payline::Error.new("message")
    a.message.should eq("message")
    a.result.should eq({})
  end

end
