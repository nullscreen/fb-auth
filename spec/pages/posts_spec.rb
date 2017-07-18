require 'spec_helper'

RSpec.describe 'Fb::Page#posts' do
  before(:each) do
    @options = {
      since: (Time.now - 28 * 86400).strftime("%Y-%m-%d"),
      until: Time.now.strftime("%Y-%m-%d")
    }
    @page = Fb::Page.new(
      "id" => "221406534569729",
      "user" => Fb::User.new(ENV['FB_TEST_ACCESS_TOKEN'])
    )
  end

  context 'given valid options and an existing Facebook page' do
    it 'returns an array of posts' do
      posts = @page.posts(@options)
      expect(posts).to be_a(Array)
      posts.each do |post|
        expect(post).to be_a Fb::Post
        expect(post.id).to be_a(String)
        expect(post.title).to be_a(String)
        expect(post.url).to be_a(String)
        expect(post.created_time).to be_a(String)
        expect(post.type).to be_a(String)
        expect(post.length).to be_a(String) if post.length
      end
    end
  end
end
