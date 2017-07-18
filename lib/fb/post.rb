# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Post reprensents a Facebook post. Post provides getters for:
  #   :id, :title, :url, :shares, :created_time, :type, and :length.
  class Post
    attr_reader :id, :title, :url, :shares, :created_time, :type, :length

    # @param [Hash] options the options to initialize an instance of Fb::Post.
    # @option [Fb::Page] :page The parent page of post.
    # @option [String] :id The post id.
    # @option [String] :title The status message in the post or post story.
    # @option [String] :url URL to the permalink page of the post.
    # @option [String] :created_time The time the post was initially published.
    # @option [String] :type A string indicating the object type of this post.
    # @option [String] :length The length of the attached video.
    def initialize(options = {})
      @page = options["page"]
      @id = options["id"]
      @title = options["message"] || options["story"]
      @url = options["permalink_url"]
      @created_time = options["created_time"]
      @type = options["type"]
      if @type == 'video' && options["properties"]
        @length = options["properties"].first["text"]
      end
    end

    # @return [Hash] a collection of metrics with metric name as key
    #   and metric object as value.
    def insights
      @insights ||= fetch_insights["data"].map do |metric_data|
        [metric_data["name"], Fb::Metric.new(metric_data)]
      end.to_h
    end

    # @return [String] the representation of the post.
    def to_s
      "#<#{self.class.name} id=#{@id}, title=#{@title}>"
    end

  private

    def fetch_insights
      Fb::Request.new(path: "/v2.9/#{@id}/insights", params: post_params).run
    end

    def post_params
      {}.tap do |params|
        params[:metric] = post_metrics.join(",")
        params[:period] = :lifetime
        params[:access_token] = @page.send(:user).send(:access_token)
      end
    end

    def post_metrics
      if @type == 'video'
        %i(post_video_views post_video_views_organic post_video_views_paid post_video_avg_time_watched post_engaged_users post_impressions)
      else
        %i(post_engaged_users post_impressions)
      end
    end
  end
end
