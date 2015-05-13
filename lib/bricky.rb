require "bricky/config"
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
end
