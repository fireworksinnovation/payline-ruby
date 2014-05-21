require 'net/http'
require 'net/https'
require 'json'

require 'payline/version'
require 'payline/urls'
require 'payline/exceptions'
require 'payline/response_handler'
require 'payline/configuration'
require 'payline/reserve_response'
require 'payline/client'



module Payline
  class << self
    attr_writer :configuration
  end

  def self.client
    Client.new(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
