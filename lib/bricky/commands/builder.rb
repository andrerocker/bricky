require "bricky/bricks"

module Bricky
  module Commands
    module Builder
      extend self

      def execute
        puts "Building Project".colorize(:light_blue)
        build(Bricky::Image.new("builder"))
      end

      private
        def build(image)
          code = command(image)
          puts "Execute build: ".colorize(:blue) + code
          
          unless system(code.gsub(/\n/, ""))
            puts "~~~~~~~~~~~ Problems building image ~~~~~~~~~~~".colorize(:white).on_red
            return false
          end

          true
        end

        def command(image)
          bricks = Bricky::Bricks.resolve
          arguments = bricks.collect(&:arguments).uniq.join(" ")
          entrypoints = bricks.collect(&:entrypoint).uniq.join(";")

          "docker run #{arguments} -i -t #{image.name} /bin/bash -l -c '#{entrypoints}'"
        end
    end
  end
end
