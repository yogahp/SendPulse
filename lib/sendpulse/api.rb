require 'sendpulse/host'
require 'net/http'
require 'json'

module SendPulse
  class Api
    attr_reader :client_id, :client_secret, :protocol, :token

    def initialize(client_id, client_secret, protocol = 'https', token = '')
      main_url = SendPulse::Host.main_url
      @url = "#{protocol}://#{main_url}"
      @client_id = client_id
      @client_secret = client_secret
      @protocol = protocol
      @refresh_token = 0
      @token = token

      if @token.nil? || @token.empty?
        raise 'Could not connect to API, check your CLIENT_ID and CLIENT_SECRET' unless refresh_token
      end
    end

    def refresh_token
      @refresh_token += 1

      data = {
        grant_type: 'client_credentials',
        client_id: @client_id,
        client_secret: @client_secret
      }

      request_data = send_request('oauth/access_token', 'POST', data, false)

      if !request_data.nil? && request_data[:data]['access_token']
        @token = request_data[:data]['access_token']
        @refresh_token = 0
      else
        return false
      end

      true
    end
    protected :refresh_token

    def send_request(path, method = 'GET', data = {}, use_token = true)
      begin
        request_data = {}

        uri = URI.parse("#{@url}/#{path}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if @protocol == 'https'

        token = {}
        token.merge!('Authorization': "Bearer #{@token}") if use_token

        case method
          when 'POST'
            request = Net::HTTP::Post.new(uri.request_uri, token)
            request.set_form_data(data)
          when 'PUT'
            request = Net::HTTP::Put.new(uri.request_uri, token)
            request.set_form_data(data)
          when 'DELETE'
            request = Net::HTTP::Delete.new(uri.request_uri, token)
            request.set_form_data(data)
          else
            request = Net::HTTP::Get.new(uri.request_uri, token)
        end

        response = http.request(request)

        if response.code.to_i == 401 && @refresh_token == 0
          refresh_token
          return send_request(path, method, data, use_token)
        else
          request_data[:data] = JSON.parse(response.body)
          request_data[:http_code] = response.code
        end
      rescue Exception => e
        raise "Exception \n message: #{e.message} \n backtrace: #{e.backtrace}"
      end

      handle_result(request_data)
    end
    protected :send_request

    def handle_result(data)
      unless data[:http_code].to_i == 200
        data[:is_error] = true
      end
      data
    end
    protected :handle_result

    def serialize(data)
      JSON.generate(data)
    end
    protected :serialize
  end
end
