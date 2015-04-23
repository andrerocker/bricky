module Bricky
  module Bricks
    class Default
      attr_accessor :config

      def initialize(config)
        self.config = config
      end
  
      def arguments
        project_path = File.expand_path(config.source)
        scripts_path = "#{bricks_path}/default"
         
        %W(-v #{project_path}:/source
           -v #{scripts_path}:/bricks/default)
      end
  
      def entrypoint
        "/bricks/default/builder"
      end

      private
        def bricks_path
          File.expand_path("../../../../etc/bricks", __FILE__)
        end
    end
  end
end
