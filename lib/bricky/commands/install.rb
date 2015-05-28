module Bricky
  module Commands
    class Install < Base
      def execute
        logger.important 'Setup bricky configuration files'
        installer = InstallThor.new
        installer.execute
      end 

      # Inner class :( just to work with thor
      class InstallThor < Thor::Group
        include Thor::Actions

        def execute
          directory 'bricky'
          copy_file 'Brickyfile'
        end

        def self.source_root
          File.expand_path('../../../../etc/templates', __FILE__)
        end
      end
    end
  end
end
