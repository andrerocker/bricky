module Bricky
  class Requirements
    def check_and_execute
      if pending?
        Bricky.logger.error "Make sure you have the following requirements: " 
        Bricky.logger.error  "  - " + requirements.keys.join("\n  - ")
      else
        yield          
      end
    end

    private
      def pending?
        requirements.detect do |command|
          not send(command.last, command.first)
        end
      end

      def requirements
        requirements = { "docker" => :which_checker }

        unless RUBY_PLATFORM.include?("linux") 
          requirements.merge!({ 
            "boot2docker" => :which_checker,
            "boot2docker up and running" => :boot2docker_checker,
            "$(boot2docker shellinit) evaluated" => :environment_checker
          }) 
        end

        requirements
      end

      def which_checker(command)
        system("which #{command} > /dev/null 2>&1")
      end

      def boot2docker_checker(*args)
        `boot2docker status`.chomp.eql?('running')
      end

      def environment_checker(*args)
        environments = ["DOCKER_HOST", "DOCKER_CERT_PATH", "DOCKER_TLS_VERIFY"]
        (environments - ENV.keys).empty?
      end
  end
end
