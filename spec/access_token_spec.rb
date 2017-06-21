require 'spec_helper'

RSpec.describe 'Fb::Auth#access_token' do
  context 'not given valid parameters' do
    it 'raises Fb::Error' do
      auth = Fb::Auth.new
      expect{auth.access_token}.to raise_error Fb::Error
    end
  end
end