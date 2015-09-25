require "base64"

module Bricky
  module Bricks
    class System < Base
      def bootstrap(bootstrap_path)
        if config.fetch('bootstrap', false)
          config.fetch('bootstrap').collect do |command|
            "RUN #{command}"
          end
        end
      end

      def arguments
        ["-v #{bricks_path}/system:/bricks/system"]
      end

      def entrypoint
        '/bricks/system/builder'
      end

      def environments
        commands = config.fetch('builder', [])
        commands.empty? ? nil : ["-e BRICKS_SYSTEM_COMMANDS='#{encode(commands)}'"]
      end

      private
      def encode(commands)
        commands.collect{|x| Base64.encode64(x).chomp}.join(';;')
      end
    end
  end
end
