module Fb
  # Provides methods to get a collection of pages that an access token is
  # allowed to manage and get page insights on those pages.
  class User
    # [String] :access_token The access token returned by Facebook's OAuth flow.
    def initialize(access_token)
      @access_token = access_token
    end

    # @return [String] the email of the Facebook user.
    def email
      @email ||= begin
        response_body = Fb::Request.new(path: '/me',
          params: {fields: :email, access_token: @access_token}).run
        response_body["email"]
      end
    end

    # @return [Array] a collection of pages available to the given access token.
    def pages
      @pages ||= begin
        response_body = Fb::Request.new(path: '/me/accounts',
          params: {access_token: @access_token}).run
        response_body["data"].map do |page_data|
          Fb::Page.new page_data.merge('user' => self)
        end
      end
    end

  private
    attr_reader :access_token
  end
end
