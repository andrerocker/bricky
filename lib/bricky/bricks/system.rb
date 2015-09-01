module Bricky
  module Bricks
    class System < Base
      def arguments
        scripts_path = "#{bricks_path}/debian"

        %W(-v #{scripts_path}:/bricks/system)
      end

      def entrypoint
        "/bricks/system/builder"
      end

      def bootstrap(bootstrap_path)
        if config.fetch('bootstrap', false)
          config.fetch('bootstrap').collect do |command|
            "RUN #{command}"
          end
        end
      end
    end
  end
end
