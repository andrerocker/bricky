module Bricky
  module Bricks
    class Debian < Base
      def arguments
        builded_path = ENV.fetch('PACKAGE_OUTPUT_PATH', File.expand_path(config["build"]))
        scripts_path = "#{bricks_path}/debian"

        %W(-v #{builded_path}:/builded
           -v #{scripts_path}:/bricks/debian)
      end
  
      def entrypoint
        "/bricks/debian/builder" 
      end
    end
  end
end
