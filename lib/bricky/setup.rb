require "bricky/image"
require "bricky/config"

module Bricky
  class Setup
    def self.start
      from_brickyfile
    end    

    private
      def self.from_brickyfile
        if File.exists?(configuration)
          eval(open("#{Dir.pwd}/Brickyfile").read) 
        end
      end

      def self.configuration
        "#{Dir.pwd}/Brickyfile"
      end
  end
end
