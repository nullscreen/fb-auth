require 'spec_helper'

RSpec.describe 'Fb::Auth#access_token' do
  context 'not given valid parameters' do
    it 'raises Fb::Error' do
      auth = Fb::Auth.new
      expect{auth.access_token}.to raise_error Fb::Error
    end
  end

  context 'given a valid code' do
    access_token = 'EAAHKcbgnqZBsBADBiSLBVJF4pXcQwRO0oK'
    auth = Fb::Auth.new code: 'valid_code'

    it 'returns a valid access_token' do
      expect(auth.access_token).to eq access_token
    end

    before do
      # Mock test for two GET requests: 
      # a call for short-term access token and another for long-term access token.
      valid_body = %Q{{"access_token":"#{access_token}","token_type":"bearer"}}
      valid_response = Net::HTTPSuccess.new(nil, nil, nil)
      expect(valid_response).to receive(:body).twice.and_return valid_body
      expect(Net::HTTP).to receive(:get_response).twice.and_return valid_response
    end
  end
end