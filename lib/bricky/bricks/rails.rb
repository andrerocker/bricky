module Bricky
  module Bricks
    class Rails < Base
      def arguments
        ["-v #{bricks_path}/rails:/bricks/rails"]
      end
  
      def entrypoint
        "/bricks/rails/builder"
      end

      def environments
        ["-e BRICKS_RAILS_ASSETS_PRECOMPILE='#{config.fetch('assets_precompile', false)}'"]
      end
    end
  end
end
