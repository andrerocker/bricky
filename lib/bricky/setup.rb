require "bricky/image"
require "bricky/config"

module Bricky
  class Setup
    def self.start
      from_brickyfile
    end    

    private
      def self.from_brickyfile
        eval(open("#{Dir.pwd}/Brickyfile").read)
      end
  end
end
