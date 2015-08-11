module Bricky
  module Bricks
    class Helper < Base
      def arguments
        ["-v #{bricks_path}/helper:/bricks/helper"].tap do |args|
          args.push("-v #{ssh_auth_socket}:/tmp/ssh-auth.socket") unless ssh_auth_socket.nil?
        end
      end

      def environments
        ["-e BRICKS_LINUX=#{linux}", '-e BRICKS_HOME=/bricks/helper'].tap do |envs|
          envs.push('-e SSH_AUTH_SOCK=/tmp/ssh-auth.socket') unless ssh_auth_socket.nil?
        end
      end

      private
        def linux
          RUBY_PLATFORM.include?("linux")
        end

        def ssh_auth_socket
          ENV['SSH_AUTH_SOCK']
        end
    end
  end
end
