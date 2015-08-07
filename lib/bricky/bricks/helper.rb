module Bricky
  module Bricks
    class Helper < Base
      def arguments
        ["-v #{bricks_path}/helper:/bricks/helper",
         "-v #{ssh_auth_socket}:/tmp/ssh-auth.socket"]
      end

      def environments
        ["-e BRICKS_LINUX=#{linux}",
         "-e BRICKS_HOME=/bricks/helper",
         "-e SSH_AUTH_SOCK=/tmp/ssh-auth.socket"]
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
