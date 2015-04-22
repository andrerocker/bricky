module Bricky
  module Commands
    module Bootstrap
      extend self

      def execute
        puts "Boostraping images".colorize(:light_blue)
        images.each {|image| build(image)}
      end

      private
        def build(image)
          code = command(image.name, image.path)
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

        def images
          ["builder", "runtime"].collect {|image| Bricky::Image.new(image) }
        end
    end
  end
end
