module Bricky
  module Bricks
    class Version < Base
      def arguments
        ["-v #{bricks_path}/version:/bricks/version"]
      end
  
      def entrypoint
        "/bricks/version/builder"
      end

      def environments
        ["-e BRICKS_VERSION_OUTPUT='#{config['output']}'"]
      end
    end
  end
end
