require "bricky/bricks/default"
require "bricky/bricks/ruby"
require "bricky/bricks/debian"

module Bricky
  module Bricks
    extend self

    def resolve
       Bricky.config.bricks.collect do |name, config|
        resolve_and_initialize(brick_name, config)
      end.uniq
    end

    def resolve_by_name(brick, config)
      return Bricky::Bricks::Ruby.new(config) if brick.eql? "ruby"
      return Bricky::Bricks::Debian.new(config) if brick.eql? "debian"

      Bricky::Bricks::Default.new 
    end
  end
end
