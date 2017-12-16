require 'fb/support'

# An object-oriented Ruby client for the Facebook Graph API.
# @see http://www.rubydoc.info/gems/fb-core/
module Fb
  # Provides methods to authenticate a user with the Facebook OAuth flow.
  # @see https://developers.facebook.com/docs/facebook-login
  class Auth
    # @param [Hash] options the options to initialize an instance of Fb::Auth.
    # @option [String] :redirect_uri The URI to redirect users to
    #   after they have completed the Facebook OAuth flow.
    # @option [String] :code A single-use authorization code provided
    #   by Facebook OAuth to obtain an access token.
    # @option [String] :refresh_token
    # @option [Array<String>] :scope
    def initialize(options = {})
      @redirect_uri = options[:redirect_uri]
      @code = options[:code]
      @refresh_token = options[:refresh_token]
      @scope = options[:scope]
    end

    # @return [Boolean] whether the authentication was revoked.
    def revoke
      !!HTTPRequest.new(revoke_options).run
    end

    # @return [String] the url to authenticate as a Facebook user.
    def url
      HTTPRequest.new(url_options).url
    end

    # @return [String] the non-expiring access token of a Facebook user.
    def access_token
      params = {redirect_uri: @redirect_uri, code: @code}
      temp_token = fetch_access_token_with params

      params = {grant_type: :fb_exchange_token, fb_exchange_token: temp_token}
      fetch_access_token_with params
    end

  private

    def url_options
      {host: 'www.facebook.com', path: '/dialog/oauth', params: url_params}
    end

    def url_params
      {}.tap do |params|
        params[:client_id] = Fb.configuration.client_id
        params[:redirect_uri] = @redirect_uri
        params[:scope] = Array(@scope).join(",")
      end
    end

    def revoke_options
      {path: '/v2.9/me/permissions', method: :delete, params: revoke_params}
    end

    def revoke_params
      {access_token: @refresh_token}
    end

    def fetch_access_token_with(params)
      params = params.merge access_token_params
      request = HTTPRequest.new path: '/oauth/access_token', params: params
      request.run.body['access_token']
    end

    def access_token_params
      {}.tap do |params|
        params[:client_id] = Fb.configuration.client_id
        params[:client_secret] = Fb.configuration.client_secret
      end
    end
  end
end
