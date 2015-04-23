module Bricky
  module Commands
    class Install < Thor::Group
      include Thor::Actions

      def execute
        puts "Setup bricky configuration files".colorize(:light_blue)
        directory "bricky"
        copy_file "Brickyfile"
      end

      def self.source_root
        File.expand_path("../../../../etc/templates", __FILE__)
      end
    end
  end
end
