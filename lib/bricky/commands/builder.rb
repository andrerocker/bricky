require "fileutils"
require "bricky/bricks"

module Bricky
  module Commands
    class Builder < Base
      def execute
        logger.important 'Building Project'
        build(Bricky::Image.new("builder"))
      end

      private
        def build(images)
          attach_shims
          code = command(images)
          logger.debug format(code)
          
          unless Bricky::Executor.system(code)
            logger.failure '~~~~~~~~~~~ Problems building image ~~~~~~~~~~~'
            return false
          end

          unless options['shell']
            logger.normal '~~~~~~~~~~~ Success \0/ ~~~~~~~~~~~'
          end

          true
        end

        def command(image)
          iteractive_hacks = options['shell'] ? "-i -t" : ""
          "docker run --rm #{envs} #{arguments} #{iteractive_hacks} #{image.name} /bricks/helper/start"
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
          environments << "-e BRICKY_ENTRYPOINTS_SHELL=#{options.fetch("shell", false)}"
          environments.join(" ")
        end

        def arguments
          args = bricks.collect(&:arguments).uniq.join(' ')
        end

        def entrypoints
          bricks.collect(&:entrypoint).compact.uniq.join(' && ')
        end

        def attach_shims
          shim = Bricky.config.shim_path
          FileUtils.safe_unlink(shim) if File.exist?(shim)
          FileUtils.symlink(Bricky.config.bricks_path, shim)
        end
    end
  end
end
