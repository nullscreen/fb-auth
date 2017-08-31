require 'spec_helper'

RSpec.describe 'Fb::Auth#revoke' do
  subject(:auth) { Fb::Auth.new }

  it 'revokes an existing authentication' do
    expect(auth.revoke).to be true
  end

  # NOTE: This test needs to be mocked because revoking a real authentication
  # requires a real token.
  before do
    # expect(auth).to receive(:tokens).once.and_return 'refresh_token' => 'b'
    expect(Fb::HTTPRequest).to receive(:new).and_return double(run: true)
  end
end
