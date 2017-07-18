require 'spec_helper'

RSpec.describe 'Fb::Page#insights' do
  before(:each) do
    @options = {
      metric: %i(page_views_total page_fan_adds_unique page_engaged_users),
      period: :week,
      since: (Time.now - 14 * 86400).strftime("%Y-%m-%d")
    }
    @page = Fb::Page.new(
      "id" => "872965469547237",
      "user" => Fb::User.new(ENV['FB_TEST_ACCESS_TOKEN'])
    )
  end

  context 'given valid options and an existing Facebook page' do
    it 'returns a hash of metrics' do
      expect(@page.insights(@options)).to be_a(Hash)
    end

    it 'returns metrics with metric name as key and metric object as value' do
      @page.insights(@options).each do |key, metric|
        expect(key).to eq metric.name
        expect(metric).to be_a Fb::Metric
        expect(metric.name).to be_a(String)
        expect(metric.description).to be_a(String)
        expect(metric.value).to be_a(Integer)
      end
    end
  end

  context 'not given any metric' do
    options = {
      period: :week,
      since: (Time.now - 14 * 86400).strftime("%Y-%m-%d")
    }

    it 'raises Fb::Error' do
      expect{@page.insights(options)}.to raise_error(Fb::Error,
        'Missing required parameter: metric')
    end
  end

  context 'given an invalid user access token' do
    page = Fb::Page.new(
      "id" => "872965469547237",
      "user" => Fb::User.new('invalid_token')
    )

    it 'raises Fb::Error' do
      expect{page.insights(@options)}.to raise_error Fb::Error
    end
  end
end
