module Fb
  # @private
  class Insight
    def self.fetch(ids, options = {})
      options.merge!(metric: options[:metric].join(","))
      self.batch_fetch(ids, options).each do |id_hash_pair|
        id_hash_pair[1] = self.to_metrics(id_hash_pair[1]["data"])
      end.to_h
    end

    def self.batch_fetch(ids, params)
      Array(ids).each_slice(50).flat_map do |batch|
        Fb::Request.new(
          path: "/v2.9/insights",
          params: params.merge!(ids: batch.join(","))
        ).run.to_a
      end
    end

    def self.to_metrics(data)
      data.map do |metric_data|
        [metric_data["name"], Fb::Metric.new(metric_data)]
      end.to_h
    end
  end
end
