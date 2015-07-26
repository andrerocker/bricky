require "etc"
require "fileutils"
require "bricky/bricks"

module Bricky
  module Commands
    class Bootstrap < Base
      def execute
        logger.important "Boostraping images"
        build(image)
      end

      private
        def build(image)
          base = command(image.name, image.path)
          hack = command(image.name, create_hack_image(image))

          [base, hack].each do |code|
            logger.message "Processing '#{image.name}' image: ", code

            unless Bricky::Executor.popen("builder", code)
              logger.failure "~~~~~~~~~~~ Problems building image ~~~~~~~~~~~"
              return false
            end
          end

          true
        end

        def command(template_name, image_path)
          "docker build -t #{template_name} #{image_path}"
        end

        def image
          @image ||= Bricky::Image.new("builder")
        end

        def create_hack_image(image)
          hacked_docker_image = parse_hack_template(image) + append_to_template
          File.open("#{hack_path}/Dockerfile", "w") { |file| file.write(hacked_docker_image) }
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

        def cache_file
          "#{Bricky.config.cache_path}/builder"
        end

        def append_to_template
          bricks.collect { |brick| brick.bootstrap(hack_path) }.flatten.join("\n")
        end

        def hack_path
          FileUtils::mkdir_p("#{Bricky.config.tmp_path}/patch/").first
        end

        def bricks
          @bricks ||= Bricky::Bricks.resolve
        end
    end
  end
end
