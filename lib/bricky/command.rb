require "thor"
require "colorize"

require "bricky/commands/check"
require "bricky/commands/bootstrap"

module Bricky
  class Command < Thor
    desc :check, "checky bricky dependencies"
    def check
      Bricky::Commands::Check.execute
    end

    desc :bootstrap, "build project images"
    def bootstrap
      Bricky::Commands::Bootstrap.execute
    end
  end
end
