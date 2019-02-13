require 'sendpulse/api'

module SendPulse
  module EmailService
    class Campaign < SendPulse::Api
      def create_template(params = {})
        send_request("template", 'POST', params)
      end

      def path_name
        "senders"
      end
    end
  end
end
