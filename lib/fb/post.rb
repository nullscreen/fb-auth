# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Post reprensents a Facebook post. Post provides getters for:
  #   :id, :title, :url, :created_time, :type, :length, and :insights.
  class Post
    attr_reader :id, :title, :url, :created_time, :type, :length, :insights

    # @param [Hash] options the options to initialize an instance of Fb::Post.
    # @option [String] :id The post id.
    # @option [String] :title The status message in the post or post story.
    # @option [String] :url URL to the permalink page of the post.
    # @option [String] :created_time The time the post was initially published.
    # @option [Hash] :insights a collection of metrics.
    # @option [String] :type A string indicating the object type of this post.
    # @option [String] :length The length of the attached video.
    def initialize(options = {})
      @id = options["id"]
      @title = options["message"] || options["story"]
      @url = options["permalink_url"]
      @created_time = options["created_time"]
      @insights = options["insights"]
      @type = options["type"]
      if @type == 'video' && options["properties"]
        @length = options["properties"].first["text"]
      end
    end

    # @return [String] the representation of the post.
    def to_s
      "#<#{self.class.name} id=#{@id}, title=#{@title}, type=#{@type}>"
    end
  end
end
