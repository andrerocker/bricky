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

      private
        def cached
          digest = Digest::MD5.file('Gemfile').hexdigest
          ["-v /tmp/bricky/cache/#{digest}:/opt/build/source/vendor/bundle"]
        end
    end
  end
end
