require 'spec_helper'

RSpec.describe 'Fb::Auth#access_token' do
  context 'not given valid parameters' do
    it 'raises Fb::HTTPError' do
      auth = Fb::Auth.new
      expect{auth.access_token}.to raise_error Fb::HTTPError
    end
  end

  context 'given a valid code' do
    access_token = '--any-valid-token--'
    auth = Fb::Auth.new code: '--any-valid-code--'

    it 'returns a valid access_token' do
      expect(auth.access_token).to eq access_token
    end

    before do
      mock = OpenStruct.new body: {'access_token' => access_token}
      allow_any_instance_of(Fb::HTTPRequest).to receive(:run).and_return mock
    end
  end
end


