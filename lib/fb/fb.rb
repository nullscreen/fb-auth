require 'fb/configuration'

module Fb
  # Returns the global [Configuration](Fb/Configuration) object. While
  # you can use this method to access the configuration, the more common
  # convention is to use [Fb.configure].
  #
  # @example
  #     Fb.configuration.fb_client_id = 1234
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Yields the global configuration to a block.
  # @yield [Configuration] global configuration
  #
  # @example
  #     Fb.configure do |config|
  #       config.fb_client_id = 1234
  #     end
  def self.configure
    yield(configuration) if block_given?
  end
end
