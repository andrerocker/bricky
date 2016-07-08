require 'digest'

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
        ["-e BRICKS_CENTOS_OUTPUT_PACKAGE_PATH=#{File.expand_path(builded_path)}",
         "-e BRICKS_CENTOS_AUTO_GENERATE_SPEC=#{config.fetch('auto_generate_spec', true)}",
         "-e BRICKS_CENTOS_REPOSITORY=#{config.fetch('repository', false)}"]
      end

      def bootstrap(bootstrap_path)
        ["RUN yum update -y",
         "RUN yum -y groupinstall 'Development Tools'"]
      end

      private
      def builded_path
        File.expand_path(ENV.fetch('BRICKY_PACKAGE_OUTPUT_PATH', config['build']))
      end
    end
  end
end
