require 'fb/request'
require 'fb/page'

module Fb
  # Provides methods to get a collection of pages that an access token is
  # allowed to manage and get page insights on those pages.
  class User
    # @access_token The access token returned by Facebook's OAuth flow.
    def initialize(access_token)
      @access_token = access_token
    end

    # @return [Array] a collection of pages available to the given access token.
    def pages
      @pages ||= begin
        response_body = Fb::Request.new(path: '/me/accounts', params: {access_token: @access_token}).run
        response_body["data"].map do |page_data|
          Fb::Page.new page_data
        end
      end
    end
  end
end
