module Bricky
  module Bricks
    class Helper < Base
      def arguments
        ["-v #{bricks_path}/helper:/bricks/helper"]
      end

      def environments
        ["-e BRICKS_LINUX=#{linux}",
         '-e BRICKS_HOME=/bricks/helper']
      end

      private

      def linux
        RUBY_PLATFORM.include?('linux')
      end
    end
  end
end
