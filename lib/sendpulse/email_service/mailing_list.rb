require 'sendpulse/api'

module SendPulse
  module EmailService
    class MailingList < SendPulse::Api
      def create(list_name)
        send_request('addressbooks', 'POST', { bookName: list_name })
      end

      def update(params)
        send_request("addressbooks/#{params[:id]}", 'PUT', params)
      end

      def list(params = {})
        send_request('addressbooks', 'GET', params)
      end

      def get(id)
        send_request("addressbooks/#{id}", 'GET')
      end

      def add_emails(params)
        send_request("addressbooks/#{params[:id]}/emails", 'POST', { id: params[:id], emails: serialize(params[:emails]) })
      end

      def get_emails(params)
        send_request("addressbooks/#{params[:id]}/emails", 'GET', params)
      end

      def delete_emails(params)
        send_request("addressbooks/#{params[:id]}/emails", 'DELETE', { emails: serialize(params[:emails]) })
      end

      def get_email(params)
        send_request("addressbooks/#{params[:id]}/emails/#{params[:email]}", 'GET', params)
      end

      def delete(id)
        send_request("addressbooks/#{id}", 'DELETE')
      end

      def cost(id)
        send_request("addressbooks/#{id}/cost", 'GET')
      end
    end
  end
end
