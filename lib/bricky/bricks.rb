require "bricky/bricks/default"
require "bricky/bricks/ruby"
require "bricky/bricks/debian"

module Bricky
  module Bricks
    extend self

    def resolve
      [Bricky.config.project.input,
       Bricky.config.package.output].collect do |brick|
        resolve_by_name(brick)
      end.uniq
    end

    def resolve_by_name(brick)
      return Bricky::Bricks::Ruby.new if brick.eql? "ruby"
      return Bricky::Bricks::Debian.new if brick.eql? "debian"

      Bricky::Bricks::Default.new 
    end
  end
end
