require 'spec_helper'

RSpec.describe 'Fb::User#pages' do
  context 'given an invalid valid access token' do
    it 'raises Fb::Error' do
      user = Fb::User.new 'invalid_token'
      expect{user.pages}.to raise_error Fb::Error
    end
  end

  context 'given a valid access_token' do
    user = Fb::User.new 'valid_token'

    it 'returns an array of pages' do
      expect(user.pages).to be_a(Array)
      expect(user.pages).to all(be_a Fb::Page)
      expect(user.pages.first.id).to eq '1234'
      expect(user.pages.first.name).to eq 'test'
    end

    before :each do
      valid_body = %Q{{"data":[{"name": "test", "id": "1234"}, {"name": "test2", "id": "1245"}], "paging": {}}}
      valid_response = Net::HTTPSuccess.new(nil, nil, nil)
      expect(valid_response).to receive(:body).and_return valid_body
      expect(Net::HTTP).to receive(:get_response).and_return valid_response
    end
  end
end
