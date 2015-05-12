require "etc"
require "fileutils"

module Bricky
  module Commands
    class Bootstrap
      def execute
        puts "Boostraping images".colorize(:light_blue)
        images.each {|image| build(image)}
      end

      private
        def build(image)
          base = command(image.name, image.path)
          hack = command(image.name, create_hack_image(image))

          [base, hack].each do |code|
            puts "Processing '#{image.name}' image: ".colorize(:blue) + code
            
            unless system(code)
              puts "~~~~~~~~~~~ Problems building image ~~~~~~~~~~~".colorize(:white).on_red
              return false
            end
          end

          true
        end

        def command(template_name, image_path)
          "docker build -t #{template_name} #{image_path}"
        end

        def images
          ["builder"].collect {|image| Bricky::Image.new(image) }
        end

        def create_hack_image(image)
          hack_path = FileUtils::mkdir_p("#{Bricky.config.tmp_path}/containers/#{Bricky.config.name}").first
          File.open("#{hack_path}/Dockerfile", "w") { |file| file.write(parse_hack_template(image)) }
          hack_path
        end

        def parse_hack_template(image)
          template = "#{Bricky.config.hacker_path}/id_container/Dockerfile"
          parser = ERB.new(open(template).read)
          variables = OpenStruct.new({ "image" => image.name, uid: Etc.getpwuid.uid })

          # :(
          def variables.get_binding
            binding
          end

          parser.result(variables.get_binding)
        end
    end
  end
end
