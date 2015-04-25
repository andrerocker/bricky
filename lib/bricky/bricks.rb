require "byebug"
require "bricky/bricks/helper"

require "bricky/bricks/ruby"
require "bricky/bricks/debian"
require "bricky/bricks/mounts"

module Bricky
  module Bricks
    extend self

    def resolve
       Bricky.config.bricks.collect do |name, config|
        resolve_and_initialize(name, config)
      end.uniq
    end

    def resolve_and_initialize(name, config)
      return Bricky::Bricks::Mounts.new(config) if name.eql? "mounts"
      return Bricky::Bricks::Debian.new(config) if name.eql? "debian"
    end
  end
end
