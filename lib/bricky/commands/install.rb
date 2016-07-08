require "thor"
require "thor/group"

module Bricky
  module Commands
    class Install < Base
      def execute(options)
        logger.important 'Setup bricky configuration files'
        installer = InstallThor.new
        installer.distribution = options
        installer.execute
      end

      # Inner class :( just to work with thor
      class InstallThor < Thor::Group
        include Thor::Actions

        def distribution=(opt)
          $distribution = opt['distribution']
        end

        def execute
          directory 'bricky'
          copy_file 'Brickyfile'
        end

        def self.source_root
          File.expand_path("../../../../etc/templates/#{$distribution}", __FILE__)
        end
      end
    end
  end
end
