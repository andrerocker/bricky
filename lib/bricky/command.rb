require 'thor'
require 'ostruct'
require 'colorize'

require 'bricky/image'
require 'bricky/requirements'
require 'bricky/commands/base'
require 'bricky/commands/install'
require 'bricky/commands/builder'
require 'bricky/commands/bootstrap'

module Bricky
  class Command < Thor
    desc :install, 'install configuration files'
    def install
      dispatch(:install)
    end

    desc :bootstrap, 'bootstrap builder images'
    def bootstrap
      requirements.check_and_execute do
        dispatch(:bootstrap)
      end
    end

    desc :builder, 'build project'
    method_option :shell, type: :boolean, aliases: '-s'
    def builder
      requirements.check_and_execute do
        dispatch(:builder)
      end
    end

    private

    def requirements
      Bricky::Requirements.new
    end

    def dispatch(name)
      clazz = Bricky::Commands.const_get("#{name.to_s.capitalize}")
      command = clazz.new(options)
      command.execute
    end
  end
end
