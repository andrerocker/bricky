require "open3"

module Bricky
  module Executor
    extend self

    def popen(label, command)
      Open3.popen2e(command) do |input, output, wait|
        output.each { |line| logger.normal label, ": #{line.chomp}" } 
        wait.value.to_i.eql?(0)
      end 
    end

    def system(command)
      Kernel.system(command)
    end

    private
      def logger
        @logger ||= Bricky::Logger.new
      end
  end
end
