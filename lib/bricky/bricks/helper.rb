module Bricky
  module Bricks
    class Helper
      attr_accessor :config

      def initialize(config)
        self.config = config
      end

      private
        def bricks_path
          File.expand_path("../../../../etc/bricks", __FILE__)
        end
    end
  end
end
