module Bricky
  module Bricks
    class Base
      attr_accessor :config

      def initialize(config)
        self.config = config
      end

      def entrypoint
      end

      def environments
      end

      private
        def bricks_path
          Bricky.config.bricks_path
        end
    end
  end
end
