require 'spec_helper'

RSpec.describe 'Fb::Post#insights' do
  before(:each) do
    page = Fb::Page.new(
      "id" => "221406534569729",
      "user" => Fb::User.new(ENV['FB_TEST_ACCESS_TOKEN'])
    )
    @post = Fb::Post.new(
      "page" => page,
      "message" => "Summer flings: it’s time to let go.",
      "permalink_url" => "https://www.facebook.com/FullscreenInc/videos/1507364515973918/",
      "type" => "video",
      "created_time" => "2017-07-17T21:00:00+0000",
      "properties" => [{"name" => "Length", "text" => "01:25"}],
      "id" => "221406534569729_1507364515973918"
    )
  end

  context 'given an existing Facebook video post' do
    it 'returns a hash of metrics' do
      expect(@post.insights).to be_a(Hash)
    end

    it 'returns metrics with metric name as key and metric object as value' do
      @post.insights.each do |key, metric|
        expect(key).to eq metric.name
        expect(metric).to be_a Fb::Metric
        expect(metric.name).to be_a(String)
        expect(metric.description).to be_a(String)
        expect(metric.value).to be_a(Integer)
      end
    end
  end
end
