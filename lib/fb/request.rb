require 'uri'
require 'net/http'
require 'json'
require 'fb/error'

module Fb
  # @private
  class Request
    def initialize(options = {})
      @host = options.fetch :host, 'graph.facebook.com'
      @path = options[:path]
      @params = options.fetch :params, {}
      unless @params.include? :access_token
        @params.merge!(client_id: ENV['FB_CLIENT_ID'])
      end
    end

    def url
      uri.to_s
    end

    def run
      res = Net::HTTP.get_response(uri)
      unless res.is_a?(Net::HTTPSuccess)
        message = JSON.parse(res.body)["error"]["message"]
        raise Fb::Error, message
      end
      JSON.parse(res.body)
    end

  private

    def uri
      query = URI.encode_www_form @params
      URI::HTTPS.build host: @host, path: @path, query: query
    end
  end
end
