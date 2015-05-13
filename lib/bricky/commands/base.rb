require "bricky/bricks"

module Bricky
  module Commands
    class Base
      attr_accessor :options

      def initialize(options)
        @options = options
      end
    end
  end
end
