require "bricky/version"
require "bricky/command"

module Bricky
  extend self

  def configure
    yield config
  end

  def config
    @config ||= Bricky::Config.new
  end
end
