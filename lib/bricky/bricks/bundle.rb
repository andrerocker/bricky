require "fileutils"

module Bricky
  module Bricks
    class Bundle < Base
      def arguments
        scripts_path = "#{bricks_path}/bundle"
        results = ["-v #{scripts_path}:/bricks/bundle"]
        results.push(cached) if config["cache"]
        results
      end
  
      def entrypoint
        "/bricks/bundle/builder"
      end

      def environments
        ["-e BRICKS_BUNDLE_WITHOUT=#{config.fetch('without', 'development:test')}"]
      end

      private
        def cached
          ["-v #{local_path}:/opt/workspace/source/vendor/bundle"]
        end

        def local_path
          path = "#{Bricky.config.tmp_path}/cache/#{digest}"
          FileUtils::mkdir_p(path)
          path
        end

        def digest
          Digest::MD5.file('Gemfile').hexdigest
        end
    end
  end
end
