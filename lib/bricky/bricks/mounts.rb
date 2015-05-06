module Bricky
  module Bricks
    class Mounts < Base
      def arguments
        scripts_path = "#{bricks_path}/mounts"
        command = "-v #{scripts_path}:/bricks/mounts"

        config.inject([command]) do |acc, mount|
          acc << "-v #{File.expand_path(mount.last)}:/bricks/mounts/volumes/#{mount.first}"
        end
      end
  
      def entrypoint
        "/bricks/mounts/builder"
      end
    end
  end
end
