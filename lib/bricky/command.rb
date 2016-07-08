require "thor"
require "ostruct"
require "colorize"

require "bricky/image"
require "bricky/requirements"
require "bricky/commands/base"
require "bricky/commands/builder"
require "bricky/commands/install"
require "bricky/commands/version"
require "bricky/commands/bootstrap"

module Bricky
  class Command < Thor
    desc :install, "install configuration files"
    method_option :distribution, :enum => ['centos', 'debian'], :type => :string, :default => 'debian', :aliases => "-d"
    def install
      dispatch(:install)
    end

    desc :builder, "build project"
    method_option :shell, :type => :boolean, :aliases => "-s"
    method_option :debugger, :type => :boolean, :aliases => "-d"
    method_option :"just-image", :type => :boolean, :aliases => "-i"
    def builder
      Bricky.logger.level = Logger::DEBUG if options['debugger']

      exit 1 unless requirements.check_and_execute do
        if options['just-image']
          dispatch(:bootstrap)
        else
          dispatch(:bootstrap) && dispatch(:builder)
        end
      end
    end

    desc :version, "bricky version"
    def version
      dispatch(:version)
    end

    private
      def requirements
        Bricky::Requirements.new
      end

      def dispatch(name)
        clazz = Bricky::Commands.const_get("#{name.to_s.capitalize}")
        clazz.new(options).execute(options)
      end
  end
end
