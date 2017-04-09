require 'sendpulse/api'
require 'base64'

module SendPulse
  class Smtp < SendPulse::Api
    def send_email(email)
      return handle_error('Empty email') if email.empty?
      email[:html] = Base64.encode64(email[:html])
      data = { email: serialize(email) }
      send_request('smtp/emails', 'POST', data)
    end

    def retrieve_emails
      send_request('smtp/emails', 'GET')
    end
  end
end
