require 'spec_helper'

describe SendPulse::Api do
  before(:each) do
    @client_id = ENV['CLIENT_ID']
    @client_secret = ENV['CLIENT_SECRET']
  end

  context "Initialize" do
    describe "Correctly initialize class" do
      let(:sendpulse_api) { described_class.new(@client_id, @client_secret, "https", nil) } 

      it { expect(sendpulse_api).to be_a SendPulse::Api }
    end
  end
end
