module Bricky
  module Commands
    module Bootstrap
      extend self

      def execute
        puts "Boostraping images".colorize(:light_blue)
        build("bricky_builder", "bricky/containers/images/builder") &&
          build("bricky_runtime", "bricky/containers/images/runtime")
      end

      private
        def build(name, image)
          code = command(name, image)
          puts "Processing #{name} image: ".colorize(:blue) + code
          
          unless system(code)
            puts "~~~~~~~~~~~ Problems building image ~~~~~~~~~~~".colorize(:white).on_red
            return false
          end

          true
        end

        def command(template_name, image_path)
          "docker build -t #{template_name} #{image_path}"
        end
    end
  end
end
