require 'uri'
require 'net/http'
require 'json'
require 'fb/error'
# A Ruby client for Facebook.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Provides methods to authenticate a user with the Facebook OAuth flow.
  # @see https://developers.facebook.com/docs/facebook-login
  class Auth
    # @param [Hash] options the options to initialize an instance of Fb::Auth.
    # @option options [String] :redirect_uri The URI to redirect users to
    #   after they have completed the Facebook OAuth flow.
    # @option options [String] :code A single-use authorization code provided
    #   by Facebook OAuth to obtain an access token.
    def initialize(options = {})
      @redirect_uri = options[:redirect_uri]
      @code = options[:code]
    end

    # @return [String] a url to Facebook's account authentication.
    def url
      url_build(
        host: 'www.facebook.com', 
        path: '/dialog/oauth', 
        params: url_params
      ).to_s
    end

    # @return [String] the non-expiring access token of an authenticated Facebook account.
    def access_token
      url = url_build(
        host: 'graph.facebook.com', 
        path: '/oauth/access_token', 
        params: long_term_token_params
      )   
      res = Net::HTTP.get_response(url)
      unless res.is_a?(Net::HTTPSuccess)
        message = JSON.parse(res.body)["error"]["message"]
        raise Fb::Error, message
      end
      JSON.parse(res.body)["access_token"]
    end

  private

    def url_build(options = {})
      query = URI.encode_www_form options[:params] 
      URI::HTTPS.build(host: options[:host], path: options[:path], query: query)
    end
    
    def short_term_access_token
      url = url_build(
        host: 'graph.facebook.com', 
        path: '/oauth/access_token', 
        params: short_term_token_params
      )   
      res = Net::HTTP.get_response(url)
      unless res.is_a?(Net::HTTPSuccess)
        message = JSON.parse(res.body)["error"]["message"]
        raise Fb::Error, message
      end
      JSON.parse(res.body)["access_token"]
    end

    def url_params
      {}.tap do |params|
        params[:client_id] = ENV['FB_CLIENT_ID']
        params[:scope] = :manage_pages
        params[:redirect_uri] = @redirect_uri
      end
    end

    def short_term_token_params
      {}.tap do |params|
        params[:client_id] = ENV['FB_CLIENT_ID']
        params[:client_secret] = ENV['FB_CLIENT_SECRET']
        params[:redirect_uri] = @redirect_uri
        params[:code] = @code
      end
    end

    def long_term_token_params
      {}.tap do |params|
        params[:client_id] = ENV['FB_CLIENT_ID']
        params[:client_secret] = ENV['FB_CLIENT_SECRET']
        params[:grant_type] = :fb_exchange_token
        params[:fb_exchange_token] = short_term_access_token
      end
    end
  end
end
