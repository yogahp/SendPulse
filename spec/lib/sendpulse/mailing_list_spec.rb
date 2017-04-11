require 'spec_helper'
require 'faker'

describe SendPulse::MailingList do
  before(:each) do
    @client_id = ENV['CLIENT_ID']
    @client_secret = ENV['CLIENT_SECRET']
  end

  context "Initialize" do
    describe "Mailing List" do
      let(:sendpulse_mailinglist) { described_class.new(@client_id, @client_secret, "https", nil) } 
      let(:mailinglist) { sendpulse_mailinglist.create("#{Faker::Book.title} #{Time.now.to_i}") }

      it do 
        expect(mailinglist[:data]).to include("id")

        id = mailinglist[:data]["id"]
        new_name = "#{Faker::Book.title} #{Time.now.to_i}"
        update_mailing_list = sendpulse_mailinglist.update({ id: id, name: new_name })
        expect(update_mailing_list[:data]).to eql({ "result" => true })
        list = sendpulse_mailinglist.list[:data]
        first_list = list[0]
        expect(first_list).to include("id")
        expect(first_list).to include("name")
        expect(first_list).to include("all_email_qty")
        expect(first_list).to include("active_email_qty")
        expect(first_list).to include("inactive_email_qty")
        expect(first_list).to include("creationdate")
        expect(first_list).to include("status")
        expect(first_list).to include("status_explain")
        single_list = sendpulse_mailinglist.get(id)[:data][0]
        expect(single_list).to include("id")
        expect(single_list).to include("name")
        expect(single_list).to include("all_email_qty")
        expect(single_list).to include("active_email_qty")
        expect(single_list).to include("inactive_email_qty")
        expect(single_list).to include("creationdate")
        expect(single_list).to include("status")
        expect(single_list).to include("status_explain")
        add_emails = sendpulse_mailinglist.add_emails(
          { 
            id: id, 
            emails: [ 
              { 
                "email": "test1@gmail.com", 
                "variables": { 
                  "variable1": "value1", 
                  "variable2": "value2" 
                } 
              }, 
              { 
                "email": "test2@gmail.com", 
                "variables": { 
                  "variable3": "value3", 
                  "variable4": "value4" 
                } 
              }, 
              { 
                "email": "test3@gmail.com", 
                "variables": { 
                  "variable5": "value5", 
                  "variable6": "value6" 
                } 
              } 
            ] 
          }
        )
        expect(add_emails[:data]).to eql({ "result" => true })
        get_emails = sendpulse_mailinglist.get_emails({ id: id })[:data]
        get_email = get_emails[0]
        expect(get_email).to include("email")
        expect(get_email).to include("status")
        expect(get_email).to include("phone")
        expect(get_email).to include("status_explain")
        expect(get_email).to include("variables")
        get_email = sendpulse_mailinglist.get_email({ id: id, email: "test1@gmail.com" })[:data]
        expect(get_email).to include("email")
        expect(get_email).to include("abook_id")
        expect(get_email).to include("phone")
        expect(get_email).to include("status")
        expect(get_email).to include("status_explain")
        expect(get_email).to include("variables")
        delete_emails = sendpulse_mailinglist.delete_emails({ id: id, emails: ["test1@gmail.com", "test2@gmail.com"] })
        expect(delete_emails[:data]).to eql({ "result" => true })
        cost = sendpulse_mailinglist.cost(id)[:data]
        expect(cost).to include("cur")
        expect(cost).to include("sent_emails_qty")
        expect(cost).to include("overdraftAllEmailsPrice")
        expect(cost).to include("addressesDeltaFromBalance")
        expect(cost).to include("addressesDeltaFromTariff")
        expect(cost).to include("max_emails_per_task")
        expect(cost).to include("result")
        delete = sendpulse_mailinglist.delete(id)
        expect(delete[:data]).to eql({ "result" => true })
      end
    end
  end
end
