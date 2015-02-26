require "mkmf"

module Bricky
  module Commands
    module Check
      extend self

      def execute
        check_dependencies "docker"
      end

      private
        def check_dependencies(*dependencies)
          dependencies.each do |dependencie|
            print "checking #{dependencie}: "

            if system("which #{dependencie} > /dev/null 2>&1")
              puts "OK"
            else
              puts "FAIL"
            end
          end
        end
    end
  end
end
