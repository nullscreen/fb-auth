require 'spec_helper'

RSpec.describe 'Fb::Page#to_s' do
  page = Fb::Page.new("name"=>"test", "id"=>"1234")

  it 'returns the string represenation' do
    expect(page.to_s).to eq '#<Fb::Page id=1234, name=test>'
  end
end
