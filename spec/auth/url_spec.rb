require 'spec_helper'

RSpec.describe 'Fb::Auth#url' do
  context 'given a valid redirect URI' do
    auth = Fb::Auth.new redirect_uri: 'http://example.com'

    it 'returns a link to Facebook authentication flow' do
      expect(auth.url).to start_with 'https://www.facebook.com/dialog/oauth'
    end

    it 'includes the redirect URI' do
      escaped_uri = CGI.escape('http://example.com')
      expect(auth.url).to include "redirect_uri=#{escaped_uri}"
    end

    it 'includes the client ID' do
      expect(auth.url).to include "client_id=#{Fb.configuration.fb_client_id}"
    end

    it 'includes the scope' do
      expect(auth.url).to include "scope=email%2Cmanage_pages"
    end
  end
end
