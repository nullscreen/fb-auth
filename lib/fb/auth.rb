require 'fb/request'
# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Provides methods to authenticate a user with the Facebook OAuth flow.
  # @see https://developers.facebook.com/docs/facebook-login
  class Auth
    # @param [Hash] options the options to initialize an instance of Fb::Auth.
    # @option [String] :redirect_uri The URI to redirect users to
    #   after they have completed the Facebook OAuth flow.
    # @option [String] :code A single-use authorization code provided
    #   by Facebook OAuth to obtain an access token.
    def initialize(options = {})
      @redirect_uri = options[:redirect_uri]
      @code = options[:code]
    end

    # @return [String] a url to Facebook's account authentication.
    def url
      Fb::Request.new(url_options).url
    end

    # @return [String] the non-expiring access token of an authenticated Facebook account.
    def access_token
      response_body = Fb::Request.new(path: '/oauth/access_token',
      params: long_term_token_params).run
      response_body["access_token"]
    end

  private

    def short_term_access_token
      response_body = Fb::Request.new(path: '/oauth/access_token',
      params: short_term_token_params).run
      response_body["access_token"]
    end

    def url_options
      url_params = {scope: 'email,manage_pages', redirect_uri: @redirect_uri}
      {host: 'www.facebook.com', path: '/dialog/oauth', params: url_params}
    end

    def short_term_token_params
      {}.tap do |params|
        params[:client_secret] = Fb.configuration.fb_client_id
        params[:redirect_uri] = @redirect_uri
        params[:code] = @code
      end
    end

    def long_term_token_params
      {}.tap do |params|
        params[:client_secret] = Fb.configuration.fb_client_secret
        params[:grant_type] = :fb_exchange_token
        params[:fb_exchange_token] = short_term_access_token
      end
    end
  end
end
