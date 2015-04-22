require "thor"
require "ostruct"
require "colorize"

require "bricky/commands/builder"
require "bricky/commands/bootstrap"

module Bricky
  class Command < Thor
    desc :bootstrap, "bootstrap project images"
    def bootstrap
      Bricky::Commands::Bootstrap.execute
    end

    desc :builder, "build project"
    def builder
      Bricky::Commands::Builder.execute
    end
  end
end
