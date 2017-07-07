require 'spec_helper'

RSpec.describe 'Fb::Metric#to_s' do
  metric = Fb::Metric.new "name"=>"test", "description"=>"test metric", "values"=>[{"value"=>1234}]

  it 'returns the string represenation' do
    expect(metric.to_s).to eq '#<Fb::Metric name=test, description=test metric, value=1234>'
  end
end
