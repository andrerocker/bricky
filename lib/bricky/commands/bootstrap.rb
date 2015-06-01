require "etc"
require "fileutils"

module Bricky
  module Commands
    class Bootstrap < Base
      def execute
        logger.important "Boostraping images"

        if need_rebuild?
          build(image)
        else
          logger.message "Skipping bootstrap process"
        end
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

          make_cache!
          true
        end

        def command(template_name, image_path)
          "docker build -t #{template_name} #{image_path}"
        end

        def image
          @image ||= Bricky::Image.new("builder")
        end

        def create_hack_image(image)
          hack_path = FileUtils::mkdir_p("#{Bricky.config.tmp_path}/patch/").first
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

        def cache_file
          "#{Bricky.config.cache_path}/builder"
        end

        def need_rebuild?
          cache_digest = open(cache_file).read rescue "dummy"
          image_digest = Digest::MD5.file(image.full_path).hexdigest

          return false if cache_digest.eql?(image_digest)
          true  
        end

        def make_cache!
          FileUtils::mkdir_p(Bricky.config.cache_path)
          open(cache_file, 'w') do |file|
            file.write Digest::MD5.file(image.full_path).hexdigest
          end
        end
    end
  end
end
