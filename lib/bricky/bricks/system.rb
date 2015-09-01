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
    end
  end
end
