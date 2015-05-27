require 'bricky/config'
require 'bricky/command'
require 'bricky/version'

module Bricky
  module_function

  def configure
    yield config
  end

  def config
    @config ||= Bricky::Config.new
  end
end
