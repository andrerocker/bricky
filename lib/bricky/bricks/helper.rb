module Bricky
  module Bricks
    class Helper < Base
      def arguments
        ["-v #{bricks_path}/helper:/bricks/helper",
          "-e BRICKS_HOME=/bricks/helper"]
      end
    end
  end
end
