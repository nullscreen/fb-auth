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
    end

    # @return [String] the representation of the page.
    def to_s
      "#<#{self.class.name} id=#{@id}, name=#{@name}>"
    end
  end
end
