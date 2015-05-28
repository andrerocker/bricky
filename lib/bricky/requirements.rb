module Bricky
  class Requirements
    def check_and_execute
      if pending?
        print "Make sure you have the following requirements: " 
        puts requirements.join(', ').colorize(:red)
      else
        yield          
      end
    end

    private
      def pending?
        requirements.detect do |command|
          not system("which #{command} > /dev/null 2>&1")
        end
      end

      def requirements
        requirements = ["docker"]
        requirements << "boot2docker" unless RUBY_PLATFORM.include?("linux") 
        requirements
      end
  end
end
