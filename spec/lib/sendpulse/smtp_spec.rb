require 'spec_helper'
require 'faker'

describe SendPulse::Smtp do
  before(:each) do
    @client_id = ENV['CLIENT_ID']
    @client_secret = ENV['CLIENT_SECRET']
    @email = {
      html: '<html><body><h1>HTML</h1></body></html>',
      text: 'Text',
      subject: 'Subject',
      from: {
        name: Faker::Name.name,
        email: ENV['FROM_EMAIL']
      },
      to: [
        {
          name: Faker::Name.name,
          email: ENV['TO_EMAIL']
        }
      ]
    }
  end

  context "Initialize" do
    describe "Sending & Retrieve Emails" do
      let(:sendpulse_smtp) { described_class.new(@client_id, @client_secret, "https", nil) } 
      let(:send_email) { sendpulse_smtp.send_email(@email) }
      let(:retrieve_emails) { sendpulse_smtp.retrieve_emails }

      it do 
        expect(sendpulse_smtp).to be_a SendPulse::Smtp
        expect(send_email[:data]).to eql({ "result" => true })
        expect(retrieve_emails[:data][0]).to include("id")
        expect(retrieve_emails[:data][0]).to include("sender")
        expect(retrieve_emails[:data][0]).to include("total_size")
        expect(retrieve_emails[:data][0]).to include("sender_ip")
        expect(retrieve_emails[:data][0]).to include("smtp_answer_code")
        expect(retrieve_emails[:data][0]).to include("smtp_answer_code_explain")
        expect(retrieve_emails[:data][0]).to include("smtp_answer_subcode")
        expect(retrieve_emails[:data][0]).to include("smtp_answer_data")
        expect(retrieve_emails[:data][0]).to include("used_ip")
        expect(retrieve_emails[:data][0]).to include("recipient")
        expect(retrieve_emails[:data][0]).to include("subject")
        expect(retrieve_emails[:data][0]).to include("send_date")
      end
    end
  end
end
