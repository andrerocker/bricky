require "bricky/image"
require "bricky/config"

module Bricky
  class Setup
    def self.start
      from_brickyfile
    end    

    private
      def self.from_brickyfile
        configuration = "#{Dir.pwd}/Brickyfile"
        if File.exists?(configuration)
          eval(open("#{Dir.pwd}/Brickyfile").read) 
        end
      end
  end
end
