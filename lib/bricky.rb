require "bricky/config"
require "bricky/logger"
require "bricky/command"
require "bricky/version"

module Bricky
  extend self

  def configure
    yield config
  end

  def config
    @config ||= Bricky::Config.new
  end

  def logger
    @logger ||= Bricky::Logger.new 
  end
end
