require 'spec_helper'

RSpec.describe 'Fb::Page#insights' do
  context 'given an invalid user access token' do
    user = Fb::User.new 'invalid_token'
    page = Fb::Page.new({"name"=>"test", "id"=>"1234", "user"=>user})

    it 'raises Fb::Error' do
      expect{page.insights}.to raise_error Fb::Error
    end
  end

  context 'given a valid user access token and an existing Facebook page' do
    user = Fb::User.new ENV['FB_TEST_ACCESS_TOKEN']
    page = Fb::Page.new({"name" => "Games",
      "id" => "872965469547237",
      "user" => user})

    it 'returns a hash of metrics' do
      expect(page.insights).to be_a(Hash)
      page.insights.each do |key, metric|
        expect(metric).to be_a Fb::Metric
        expect(key).to eq metric.name
        expect(metric.name).to be_a(String)
        expect(metric.description).to be_a(String)
        expect(metric.value).to be_a(Integer)
      end
    end
  end
end
