module Bricky
  module Bricks
    class Default
      def arguments
        project_path = File.expand_path(".")
        script_path = "#{bricks_path}/default"
        
        %W(
          -v #{project_path}:/source
          -v #{script_path}:/bricks/default
        )
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
