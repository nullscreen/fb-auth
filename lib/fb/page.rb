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

    # @param [Hash] options to customize the insights returned from the API.
    # @option [String] :since The lower bound of the time range to consider.
    # @option [String] :period The aggregation period (must be available to all
    #   given metrics).
    # @option [Array<String, Symbol>] :metric A list of metrics.
    # @return [Hash] a collection of metrics with metric name as key
    #   and metric object as value.
    # @example
    #   page = Fb::User.new('token').pages.first
    #   page.insights(options)
    #   => {"page_fan_adds_unique"=>#<Fb::Metric:0x123abc
    #   @name="page_fans", @description="Weekly: The
    #   number of new people who have liked your Page (Unique Users)",
    #   @value=123>,..}
    def insights(options = {})
      fetch_insights(options)["data"].map do |metric_data|
        [metric_data["name"], Fb::Metric.new(metric_data)]
      end.to_h
    end

    # @return [String] the representation of the page.
    def to_s
      "#<#{self.class.name} id=#{@id}, name=#{@name}>"
    end

  private

    def fetch_insights(options)
      unless options[:metric]
        raise Fb::Error, 'Missing required parameter: metric'
      end
      insights_params = options.merge(metric: options[:metric].join(","),
        access_token: @user.send(:access_token))
      Fb::Request.new(
        path: "/v2.9/#{@id}/insights",
        params: insights_params
      ).run
    end
  end
end
