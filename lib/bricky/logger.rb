require "logger"

module Bricky
  class Logger < ::Logger
    def initialize
      super(STDOUT)
      self.level = INFO
      self.formatter = proc do |severity, datetime, progname, msg|
        "#{msg}\n"
      end
    end

    def message(*args)
      info colorize_first(args, :blue)
    end

    def failure(*args)
      error colorize_first(args, :white).on_red
    end

    def important(*args)
      info colorize_first(args, :cyan)
    end

    def normal(*args)
      info colorize_first(args, :green)
    end

    private
      def colorize_first(args, color)
        [args.first.colorize(color), args[1..-1]].join
      end
  end
end
