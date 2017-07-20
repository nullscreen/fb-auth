# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Page reprensents a Facebook page. Page provides getters for:
  #   :name and :id
  class Page
    attr_reader :name, :id

    # @param [Hash] options the options to initialize an instance of Fb::Page.
    # @option [Fb::User] :user The user that manages this page.
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
    def insights(options = {})
      options.merge!(access_token: @user.send(:access_token))
      Insight.fetch(@id, options)[@id]
    end

    # @param [Hash] options to customize the posts returned from the API.
    # @option [String] :since The lower bound of the time range to consider.
    # @option [String] :until The upper bound of the time range to consider.
    # @option [String] :type A string indicating the type of post to fetch.
    #   Available types: link, status, photo, video, and offer.
    # @return [Array<Fb::Post>] a collection of posts.
    def posts(options = {})
      posts = fetch_posts(options)["data"]
      post_ids = posts.map {|post| post.values.last}
      insights = Insight.fetch(post_ids, options.merge(post_insights_params))
      posts.map do |post_data|
        Fb::Post.new(post_data.merge("insights" => insights[post_data.values.last]))
      end
    end

    # @return [String] the representation of the page.
    def to_s
      "#<#{self.class.name} id=#{@id}, name=#{@name}>"
    end

  private

    def fetch_posts(options)
      posts_params = options.merge(
        fields: 'message,story,permalink_url,type,created_time,properties',
        limit: 100,
        access_token: @user.send(:access_token)
      )
      Fb::Request.new(path: "/v2.9/#{@id}/posts", params: posts_params).run
    end

    def post_insights_params
      {}.tap do |params|
        params[:metric] = post_metrics
        params[:period] = :lifetime
        params[:access_token] = @user.send(:access_token)
      end
    end

    def post_metrics
      %i(post_video_views post_video_views_organic post_video_views_paid post_video_avg_time_watched post_engaged_users post_impressions)
    end
  end
end
