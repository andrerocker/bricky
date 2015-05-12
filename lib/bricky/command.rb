require "thor"
require "ostruct"
require "colorize"

require "bricky/commands/install"
require "bricky/commands/builder"
require "bricky/commands/bootstrap"

module Bricky
  class Command < Thor
    desc :install, "copy configuration files"
    def install
      command = Bricky::Commands::Install.new
      command.execute
    end

    desc :bootstrap, "bootstrap project images"
    def bootstrap
      command = Bricky::Commands::Bootstrap.new 
      command.execute
    end

    desc :builder, "build project"
    method_option :shell, :type => :boolean, :aliases => "-s"
    def builder
      command = Bricky::Commands::Builder.new(options)
      command.execute
    end
  end
end
