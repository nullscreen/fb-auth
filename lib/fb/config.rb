require 'ostruct'

module Fb  
  def self.configure
    @config ||= OpenStruct.new
    yield(@config) if block_given?
    @config
  end

  def self.configuration
    @config || configure
  end
end