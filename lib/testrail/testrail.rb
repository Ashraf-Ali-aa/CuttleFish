require 'typhoeus'
require 'uri'
require 'base64'

module TestRail
  class APIClient
    @url      = ''
    @user     = ''
    @password = ''

    attr_accessor :user
    attr_accessor :password

    def initialize(base_url)
      base_url += '/' unless base_url =~ /\/$/
      @url      = base_url + 'index.php?/api/v2/'
    end

    def send_get(uri)
      _send_request method: 'GET',
                    uri:     uri
    end

    def send_post(uri, data)
      _send_request method: 'POST',
                    uri:     uri,
                    data:    data
    end

    private

    def _send_request(opts = {})
      api_method = opts.fetch :method
      uri        = opts.fetch :uri
      data       = opts.fetch(:data, nil)
      url        = File.join(@url, uri)

      request = Typhoeus::Request.new(
        url,
        method:  api_method.downcase.to_sym,
        body:    JSON.dump(data),
        headers: { 'Content-Type' => 'application/json',
                   'Authorization' => "Basic #{Base64.strict_encode64("#{@user}:#{@password}")}" }
      )
      response = request.run

      if response.code == 504
        Log.error "504 Gateway Time-out. The server didn't respond in time."
        nil
      else
        begin
          JSON.parse(response.body)
        rescue JSON::ParserError
          response.body
        end
      end
    end
  end
end
