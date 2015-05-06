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
          puts format(code)
          
          unless Kernel.exec(code)
            puts "~~~~~~~~~~~ Problems building image ~~~~~~~~~~~".colorize(:white).on_red
            return false
          end

          true
        end

        def command(image)
          bricks = Bricky::Bricks.resolve
          arguments = bricks.collect(&:arguments).uniq.join(" ")
          entrypoints = bricks.collect(&:entrypoint).compact.uniq.join(" && ")

          "docker run #{arguments} -i -t #{image.name} /bin/bash -l -c '#{entrypoints}'"
        end

        def format(command)
          command.split("-v ").join("\n\t -v ").split("-i ").join("\n\t -i ")
        end
    end
  end
end
