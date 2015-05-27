require 'bricky/bricks'

module Bricky
  module Commands
    class Builder < Base
      def execute
        puts 'Building Project'.colorize(:light_blue)
        build(Bricky::Image.new('builder'))
      end

      private

      def build(images)
        code = command(images)
        puts format(code)

        unless system(code)
          puts '~~~~~~~~~~~ Problems building image ~~~~~~~~~~~'.colorize(:white).on_red
          return false
        end

        true
      end

      def command(image)
        "docker run #{envs} #{arguments} -i -t #{image.name} /bricks/helper/start"
      end

      def format(command)
        ['-v ', '-i ', '-e '].inject(command) do |result, param|
          result.split(param).join("\n\t #{param}")
        end
      end

      def bricks
        @bricks ||= Bricky::Bricks.resolve
      end

      def envs
        environments = bricks.collect(&:environments)
        environments << "-e BRICKY_ENTRYPOINTS='#{entrypoints}'"
        environments << "-e BRICKY_ENTRYPOINTS_SHELL=#{options.fetch('shell', false)}"
        environments.join(' ')
      end

      def arguments
        bricks.collect(&:arguments).uniq.join(' ')
      end

      def entrypoints
        bricks.collect(&:entrypoint).compact.uniq.join(' && ')
      end
    end
  end
end
