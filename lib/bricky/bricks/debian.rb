module Bricky
  module Bricks
    class Debian < Default
      def arguments
        builded_path = File.expand_path(Bricky.config.package.build)
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
