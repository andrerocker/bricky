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
          
          unless system(code)
            puts "~~~~~~~~~~~ Problems building image ~~~~~~~~~~~".colorize(:white).on_red
            return false
          end

          true
        end

        def command(image)
          bricks = Bricky::Bricks.resolve
          envs = bricks.collect(&:environments).uniq.join(" ")
          arguments = bricks.collect(&:arguments).uniq.join(" ")
          entrypoints = bricks.collect(&:entrypoint).compact.uniq.join(" && ")

          "docker run #{envs} #{arguments} -i -t #{image.name} /bin/bash -l -c '#{entrypoints}'"
        end

        def format(command)
          ["-v ", "-i ", "-e "].inject(command) do |result, param|
            result.split(param).join("\n\t #{param}")
          end
        end
    end
  end
end
