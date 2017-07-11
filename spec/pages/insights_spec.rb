require 'spec_helper'

RSpec.describe 'Fb::Page#insights' do
  before(:each) do
    @options = {
      metric: %i(page_views_total page_fan_adds_unique page_engaged_users),
      period: :week,
      since: (Time.now - 14 * 86400).strftime("%Y-%m-%d")
    }
  end

  context 'given an invalid user access token' do
    page = Fb::Page.new(
      "name"=>"test",
      "id"=>"1234",
      "user"=>Fb::User.new('invalid_token')
    )

    it 'raises Fb::Error' do
      expect{page.insights(@options)}.to raise_error Fb::Error
    end
  end

  context 'given valid options and an existing Facebook page' do
    page = Fb::Page.new(
      "name" => "Games",
      "id" => "872965469547237",
      "user" => Fb::User.new(ENV['FB_TEST_ACCESS_TOKEN'])
    )

    it 'returns a hash of metrics' do
      expect(page.insights(@options)).to be_a(Hash)
      page.insights(@options).each do |key, metric|
        expect(metric).to be_a Fb::Metric
        expect(key).to eq metric.name
        expect(metric.name).to be_a(String)
        expect(metric.description).to be_a(String)
        expect(metric.value).to be_a(Integer)
      end
    end
  end
end
