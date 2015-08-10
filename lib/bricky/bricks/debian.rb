require 'digest'

module Bricky
  module Bricks
    class Debian < Base
      def arguments
        scripts_path = "#{bricks_path}/debian"

        %W(-v #{builded_path}:/builded
           -v #{scripts_path}:/bricks/debian)
      end

      def entrypoint
        "/bricks/debian/builder"
      end

      def environments
        ["-e BRICKS_DEBIAN_OUTPUT_PACKAGE_PATH=#{File.expand_path(builded_path)}",
         "-e BRICKS_DEBIAN_CHANGELOG=#{config.fetch('changelog', false)}"]
      end

      def bootstrap(bootstrap_path)
        if config.fetch('dependencies', false)
          src = File.expand_path('debian/control')
          dest = "#{bootstrap_path}/control"

          FileUtils.cp(src, dest) unless skip_cached_file(src, dest)
          ["COPY control /tmp/control", "RUN yes | mk-build-deps --install /tmp/control"]
        end
      end

      private
      def builded_path
        File.expand_path(ENV.fetch('BRICKY_PACKAGE_OUTPUT_PATH', config['build']))
      end

      def skip_cached_file(src, dest)
        return false if not File.exists?(dest)

        src_digest = Digest::SHA256.file(src).hexdigest
        dest_digest = Digest::SHA256.file(dest).hexdigest
        not src_digest.eql?(dest_digest) ? false : true
      end
    end
  end
end
