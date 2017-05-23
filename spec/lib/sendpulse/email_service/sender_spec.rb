require 'spec_helper'
require 'faker'
require 'tempmailru/api'
require 'nokogiri'

describe SendPulse::EmailService::Sender do
  before(:each) do
    @client_id = ENV['CLIENT_ID']
    @client_secret = ENV['CLIENT_SECRET']
    @sendpulse_sender = described_class.new(@client_id, @client_secret, "https", nil)
  end

  context "Sender wrapper" do
    describe "List" do
      it do
        data = @sendpulse_sender.list[:data]
        expect(data).to be_a_kind_of(Array)
      end
    end

    describe "Create / Delete / Activating" do
      it do
        expected_result = {:data=>{"error_code"=>903, "message"=>"Empty sender email"}, :http_code=>"400", :is_error=>true}
        expect(@sendpulse_sender.create({})).to eql(expected_result)
      end

      it do
        tempmailru_api = TempMailRu::Api.new(nil, "http")
        email = "test#{tempmailru_api.domains[0]}"
        name = Faker::Name.name
        params = {
          email: email,
          name: name
        }
        expected_result = {:data=>{"result"=>true}, :http_code=>"200"}
        expect(@sendpulse_sender.create(params)).to eql(expected_result)
        expected_result = {:data=>{"result"=>true, "email"=>"test@binka.me"}, :http_code=>"200"}
        expect(@sendpulse_sender.get_activate_code(email)).to eql(expected_result)
        sleep 1
        tempmailru_api.email = email
        doc = Nokogiri::HTML(tempmailru_api.inbox[-1][:mail_text_only])
        doc_css_strong = doc.css('strong')[1]
        code = doc_css_strong.to_s[8..-10]
        params = {
          email: email,
          code: code
        }
        expected_result = {:data=>{"result"=>true, "email"=>"test@binka.me"}, :http_code=>"200"}
        expect(@sendpulse_sender.activate(params)).to eql(expected_result)
        list = @sendpulse_sender.list
        expect(list[:data].select { |d| d["email"] == email }[0]["status"]).to eql "Active"
        expected_result = {:data=>{"result"=>true}, :http_code=>"200"}
        expect(@sendpulse_sender.delete(email)).to eql(expected_result)
      end
    end
  end
end
