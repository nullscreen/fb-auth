require 'spec_helper'

RSpec.describe 'Fb.configure' do
  after :all do
    Fb.configure do |config|
      config.fb_client_id = ENV['FB_CLIENT_ID']
      config.fb_client_secret = ENV['FB_CLIENT_SECRET']
    end
  end

  it 'should return nil if no block is given' do
    expect(Fb.configure).to be(nil)
  end

  describe "given a block with: { |config| config.fb_client_id = '123' }" do
    before do
      Fb.configure { |config| config.fb_client_id = '123' }
    end
    it 'should change the Configuration#fb_client_id to 123' do
      expect(Fb.configuration.fb_client_id).to eq('123')
    end
  end

  describe "given a block with: { |config| config.fb_client_secret = 'abc' }" do
    before do
      Fb.configure { |config| config.fb_client_secret = 'abc' }
    end
    it 'should change the Configuration#fb_client_secret to abc' do
      expect(Fb.configuration.fb_client_secret).to eq('abc')
    end
  end
end