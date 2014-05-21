module Payline
  class ResponseHandler

    def parse(text)
      # CGI by default returns an hash of arrays even if there is one element (is is the norm)
      hash = CGI::parse(text)
      hash.each {|k, v|
        hash[k] = v.length == 1 ? v.first : v
      }
      hash
    end

    def parse_and_handle_errors(text)
      hash = parse(text)
      handle_errors(hash)
      hash
    end

    def handle_errors(hash)
      if hash['PROCESSING.REASON.CODE'].to_s != '00'
        # Error message should be friendly
        raise Payline::Error.new(hash['PROCESSING.RETURN'])
      end
    end
  end
end
