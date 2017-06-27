require 'spec_helper'

RSpec.describe 'Fb::User#pages' do
  context 'given an invalid valid access token' do
    it 'raises Fb::Error' do
      user = Fb::User.new 'invalid_token'
      expect{user.pages}.to raise_error Fb::Error
    end
  end

  context 'given a valid access_token' do
    user = Fb::User.new ENV['FB_TEST_ACCESS_TOKEN']

    it 'returns an array of pages' do
      expect(user.pages).to be_a(Array)
      expect(user.pages).to all(be_a Fb::Page)
      expect(user.pages.first.id).to be_a(String)
      expect(user.pages.first.name).to be_a(String)
    end
  end
end
