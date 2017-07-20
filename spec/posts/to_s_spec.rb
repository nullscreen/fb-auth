require 'spec_helper'

RSpec.describe 'Fb::Post#to_s' do
  post = Fb::Post.new("message"=>"test", "id"=>"1234", "type"=>"video")

  it 'returns the string represenation' do
    expect(post.to_s).to eq '#<Fb::Post id=1234, title=test, type=video>'
  end
end
