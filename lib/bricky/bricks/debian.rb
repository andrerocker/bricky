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
         "-e BRICKS_DEBIAN_CHANGELOG=#{config.fetch('changelog', false)}",
         "-e BRICKS_DEBIAN_REPOSITORY=#{config.fetch('repository', false)}"]
      end

      def bootstrap(bootstrap_path)
        ["RUN apt-get install -y --force-yes libfile-fcntllock-perl"].tap do |deps|
          deps << package_build_dependencies(bootstrap_path) if config.fetch('dependencies', false)
        end
      end

      private
      def builded_path
        File.expand_path(ENV.fetch('BRICKY_PACKAGE_OUTPUT_PATH', config['build']))
      end

      def package_build_dependencies(bootstrap_path)
        ["COPY control /tmp/control", "RUN yes | mk-build-deps --install /tmp/control"].tap do |deps|
          src, dest = File.expand_path('debian/control'), "#{bootstrap_path}/control"
          FileUtils.cp(src, dest) unless skip_cached_file(src, dest)
        end
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
