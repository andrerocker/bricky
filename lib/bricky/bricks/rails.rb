module Bricky
  module Bricks
    class Rails < Base
      def arguments
        ["-v #{bricks_path}/rails:/bricks/rails"].push(assets_cached)
      end
  
      def entrypoint
        "/bricks/rails/builder"
      end

      def environments
        ["-e BRICKS_RAILS_ASSETS_PRECOMPILE='#{config.fetch('assets_precompile', false)}'",
         "-e BRICKS_RAILS_ASSETS_PRECOMPILE_CACHED_DIGEST='#{digest}'"]
      end

      private
      def assets_cached
        ["-v #{local_path}:/opt/workspace/source/public/assets"]
      end

      def local_path
        "#{Bricky.config.cache_path}/rails/assets/#{digest}".tap { |path| FileUtils::mkdir_p(path) }
      end

      def digest
        @digest ||= %x(find app/assets -type f -exec md5sum {} \\; | md5sum).split.first
      end
    end
  end
end
