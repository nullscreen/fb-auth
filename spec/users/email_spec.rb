require 'spec_helper'

RSpec.describe 'Fb::User#email' do
  context 'given an invalid valid access token' do
    it 'raises Fb::Error' do
      user = Fb::User.new 'invalid_token'
      expect{user.email}.to raise_error Fb::Error
    end
  end

  context 'given a valid access_token' do
    user = Fb::User.new ENV['FB_TEST_ACCESS_TOKEN']

    it 'returns the email of the user' do
      expect(user.email).to be_a(String)
    end
  end
end
