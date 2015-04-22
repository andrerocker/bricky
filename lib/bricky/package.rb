module Bricky
  class Package
    attr_accessor :image

    def initialize(image)
      self.image = image
    end

    project_path = File.expand_path(".")
    builded_path = File.expand_path(Bricky.config.package.build)
    cachedz_path = File.expand_path(Bricky.config.package.cache)

    def script
      "#{script_path}/#{image.name}" 
    end
 
    def script_path
      "#{Bricky.config.full_scripts_path}/#{Bricky.config.package.output}"
    end
  end
end
