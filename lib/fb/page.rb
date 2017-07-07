require 'date'
require 'fb/request'
require 'fb/metric'
# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Page reprensents a Facebook page.
  # Provides methods to get/set a page's name and id.
  class Page
    # @return [String] the name of the page.
    attr_reader :name

    #@return [String] the unique id of the page.
    attr_reader :id

    # @param [Hash] options the options to initialize an instance of Fb::Page.
    # @option [String] :name The name of the page.
    # @option [String] :id The unique id of the page.
    def initialize(options = {})
      @name = options["name"]
      @id = options["id"]
      @user = options["user"]
    end

    # @return [Hash] a collection of metrics with metric name as key
    #   and metric object as value.
    # @example
    #   Fb::User.new('token').pages.insights
    #   => {"page_fan_adds_unique"=>#<Fb::Metric:0x123abc
    #   @name="page_fans", @description="Weekly: The
    #   number of new people who have liked your Page (Unique Users)",
    #   @value=123>,..}
    def insights
      @insights ||= begin
        response_body = Fb::Request.new(
          path: "/v2.9/#{@id}/insights",
          params: insights_params).run
        response_body["data"].map do |metric_data|
          [metric_data["name"], Fb::Metric.new(metric_data)]
        end.to_h
      end
    end

    # @return [String] the representation of the page.
    def to_s
      "#<#{self.class.name} id=#{@id}, name=#{@name}>"
    end

  private

    def insights_params
      {}.tap do |params|
        params[:since] = (Time.now - 14 * 86400).strftime("%Y-%m-%d")
        params[:until] = Date.parse(params[:since]) + 1
        params[:period] = :week
        params[:metric] = 'page_views_total,page_fan_adds_unique,
          page_engaged_users,page_video_views'
        params[:access_token] = @user.send(:access_token)
      end
    end
  end
end
