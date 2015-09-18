require "open3"

module Bricky
  module Executor
    extend self

    def popen(label, command)
      execute(command) do |line|
        logger.normal label.rjust(8), ": #{line.chomp}"
      end
    end

    def system(command)
      execute(command) do |line|
        logger.info line.chomp
      end
    end

    private
      def execute(command)
        Open3.popen2e(command) do |input, output, wait|
          output.each { |line| yield(line) }
          wait.value.to_i.eql?(0)
        end
      end

      def logger
        Bricky.logger
      end
  end
end
