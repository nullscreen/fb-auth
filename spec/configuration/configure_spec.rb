require 'spec_helper'

RSpec.describe 'Fb.configure' do

  it 'should return nil if no block is given' do
    expect(Fb.configure).to be(nil)
  end

  describe "given a block with: { |config| config.client_id = '123' }" do
    before do
      Fb.configure { |config| config.client_id = '123' }
    end
    it 'should change the Configuration#client_id to 123' do
      expect(Fb.configuration.client_id).to eq('123')
    end
  end

  describe "given a block with: { |config| config.client_secret = 'abc' }" do
    before do
      Fb.configure { |config| config.client_secret = 'abc' }
    end
    it 'should change the Configuration#client_secret to abc' do
      expect(Fb.configuration.client_secret).to eq('abc')
    end
  end
end
