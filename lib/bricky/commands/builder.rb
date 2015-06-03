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
          if not File.exist? Bricky.config.shim_path
            FileUtils.symlink(Bricky.config.bricks_path, Bricky.config.shim_path)
          end
        end
    end
  end
end
