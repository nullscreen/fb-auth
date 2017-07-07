# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Metric reprensents a Facebook page's metric.
  # For a list of all available metrics, refer to:
  # @see https://developers.facebook.com/docs/graph-api/reference/v2.9/insights
  # Provides methods to read name, description, and value.
  class Metric

    # @return [String] the name of the metric (e.g. page_fans).
    attr_reader :name

    # @return [String] a description for the metric.
    attr_reader :description

    # @return [Integer] the value of the metric when last requested.
    attr_reader :value

    # @param [Hash] options the options to initialize an instance of Fb::Metric.
    # @option [String] :name of the metric.
    # @option [String] :title of the metric.
    # @option [String] :description of the metric.
    # @option [Integer] :value of this metric when last requested.
    def initialize(options = {})
      @name = options["name"]
      @description = options["description"]
      @value = options["values"].first["value"]
    end

    # @return [String] the representation of the metric.
    def to_s
      "#<#{self.class.name} name=#{@name}, description=#{@description}, value=#{@value}>"
    end
  end
end
