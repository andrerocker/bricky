module Bricky
  module Bricks
    class Dotenv < Base
      def entrypoint
        "/bricks/dotenv/builder"
      end

      def arguments
        ["-v #{bricks_path}/dotenv:/bricks/dotenv"]
      end

      def environments
        ["-e BRICKS_DOTENV_SOURCE_FILES='#{config.fetch('source', []).join(',')}'"]
      end
    end
  end
end
