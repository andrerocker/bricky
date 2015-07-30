module Bricky
  module Bricks
    class Version < Base
      def arguments
        ["-v #{bricks_path}/version:/bricks/rails"]
      end
  
      def entrypoint
        "/bricks/version/builder"
      end

      def environments
        ["-e BRICKS_RAILS_ASSETS_PRECOMPILE='#{config.fetch('assets_precompile', false)}'"]
      end
    end
  end
end
