module Bricky
  module Bricks
    class Mounts < Base
      def arguments
        result = config.inject([commands_volume]) do |acc, mount|
          acc << mount_point(mount.last, mount.first) if not mount.first.eql? "ignore"
          acc
        end
      end
  
      def entrypoint
        "/bricks/mounts/builder"
      end

      def environments
        ["-e BRICKS_MOUNTS_IGNORE='#{config.fetch('ignore', []).join(',')}'"]
      end

      private
        def commands_volume
          "-v #{bricks_path}/mounts:/bricks/mounts"
        end

        def mount_point(path, name)
          "-v #{File.expand_path(path)}:/bricks/mounts/volumes/#{name}"
        end
    end
  end
end
