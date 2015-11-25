module Bricky
  module Bricks
    class Centos < Base
      def arguments
        scripts_path = "#{bricks_path}/centos"

        %W(-v #{builded_path}:/builded
           -v #{scripts_path}:/bricks/centos)
      end

      def entrypoint
        "/bricks/centos/builder"
      end

      def environments
      end

      def bootstrap(bootstrap_path)
      end

      private
        def builded_path
          File.expand_path(config['build'])
        end
    end
  end
end
