require 'uri'

# A Ruby client for Facebook.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Provides methods to authenticate a user with the Facebook OAuth flow.
  # @see https://developers.facebook.com/docs/facebook-login
  class Auth
    # @param [Hash] options the options to initialize an instance of Fb::Auth.
    # @option options [String] :redirect_uri The URI to redirect users to
    #   after they have completed the Facebook OAuth flow.
    def initialize(options = {})
      @redirect_uri = options[:redirect_uri]
    end

    # @return [String] a url to Facebook's account authentication
    def url
      host = 'www.facebook.com'
      path = '/dialog/oauth'
      query = URI.encode_www_form url_params
      URI::HTTPS.build(host: host, path: path, query: query).to_s
    end

  private
    def url_params
      {}.tap do |params|
        params[:client_id] = ENV['FB_CLIENT_ID']
        params[:scope] = :manage_pages
        params[:redirect_uri] = @redirect_uri
      end
    end
  end
end
