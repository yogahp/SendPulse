require 'spec_helper'

describe SendPulse::EmailService::Campaign do
  before(:each) do
    @client_id = ENV['CLIENT_ID']
    @client_secret = ENV['CLIENT_SECRET']
    @sendpulse_campaign = described_class.new(@client_id, @client_secret, "https", nil)
  end

  context "Campaigns Wrapper" do
    describe "Template Creation" do
      it do
        expected_result = {:data=>{"error_code"=>572, "message"=>"Emty template body"}, :http_code=>"400", :is_error=>true}
        create_template = @sendpulse_campaign.create_template
        expect(create_template).to eql expected_result
      end

      it do
        create_template = @sendpulse_campaign.create_template({ name: "Template #{Time.now.to_i}", body: Base64.encode64("<h1>Template Body</h1><p>Description</p>") })
        expected_result = {:data=>{"result"=>true}, :http_code=>"200"}
        expect(create_template).to eql expected_result
      end
    end
  end
end
