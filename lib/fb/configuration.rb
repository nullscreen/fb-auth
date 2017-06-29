module Fb
  # Setter for shared global objects
  # @private
  class Configuration
    attr_accessor :fb_client_id, :fb_client_secret

    def initialize
      @fb_client_id = ENV['FB_CLIENT_ID']
      @fb_client_secret = ENV['FB_CLIENT_SECRET']
    end
  end
end
