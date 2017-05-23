require 'sendpulse/api'

module SendPulse
  module EmailService
    class Sender < SendPulse::Api
      def list
        send_request(path_name, 'GET')
      end

      def create(params)
        send_request(path_name, 'POST', params)
      end

      def delete(email)
        send_request(path_name, 'DELETE', { email: email })
      end

      def get_activate_code(email)
        send_request("#{path_name}/#{email}/code", 'GET')
      end

      def activate(params)
        send_request("#{path_name}/#{params[:email]}/code", 'POST', { code: params[:code] })
      end

      def path_name
        "senders"
      end
    end
  end
end
