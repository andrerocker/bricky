require "bricky/bricks/base"

require "bricky/bricks/helper"
require "bricky/bricks/ruby"
require "bricky/bricks/rails"
require "bricky/bricks/bundle"
require "bricky/bricks/debian"
require 'bricky/bricks/dotenv'
require "bricky/bricks/mounts"
require "bricky/bricks/version"

module Bricky
  module Bricks
    extend self

    def resolve
      default_bricks + Bricky.config.bricks.collect do |name, config|
       resolve_and_initialize(name, config)
      end.uniq
    end

    private
      def default_bricks
        [Bricky::Bricks::Helper.new({})]
      end

      def resolve_and_initialize(name, config)
        Bricky::Bricks.const_get("#{name.to_s.capitalize}").new(config)
      end
  end
end
