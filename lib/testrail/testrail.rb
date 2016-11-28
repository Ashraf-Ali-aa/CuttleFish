# TestRail API binding for Ruby (API v2, available since TestRail 3.0)
#
# Learn more:
#
# http://docs.gurock.com/testrail-api2/start
# http://docs.gurock.com/testrail-api2/accessing
#
# Copyright Gurock Software GmbH. See license.md for details.
#
# require 'pry'
require 'net/http'
require 'net/https'
require 'uri'
require 'json'

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

    # Issues a GET request (read) against the API and returns the result
    # Send: Get
    # Type: Hash
    # Example: get_case/1
    # Params:
    #   uri - The API method to call including parameters

    def send_get(uri)
      send_request('GET', uri, nil)
    end

    # Issues a POST request (write) against the API and returns the result
    # Send: Post
    # Type: Hash
    # Example: get_case/1
    # Params:
    #   uri    - The API method to call including parameters
    #   config - The config to submit as part of the request

    def send_post(uri, data)
      send_request('POST', uri, data)
    end

    private

    def send_request(method, uri, data)
      url = URI.parse(@url + uri)
      if method == 'POST'
        request      = Net::HTTP::Post.new(url.path + '?' + url.query)
        request.body = JSON.dump(data)
      else
        request = Net::HTTP::Get.new(url.path + '?' + url.query)
      end
      request.basic_auth(@user, @password)
      request.add_field('Content-Type', 'application/json')

      connection = Net::HTTP.new(url.host, url.port)

      if url.scheme == 'https'
        connection.use_ssl     = true
        connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      # binding.pry
      response = connection.request(request)

      result = response.body && !response.body.empty? ? JSON.parse(response.body) : {}

      if response.code != '200'
        error = if result && result.key?('error')
                  '"' + result['error'] + '"'
                else
                  'No additional error message received'
                end
        raise APIError, 'TestRail API returned HTTP %s (%s)' %
                        [response.code, error]
      end

      result
    end
  end

  class APIError < StandardError
  end
end
