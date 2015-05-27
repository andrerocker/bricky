module Bricky
  class Image
    attr_accessor :name
    attr_accessor :path

    def initialize(image)
      self.name = format_name(image)
      self.path = format_path(image)
    end

    private

    def format_name(image)
      "#{Bricky.config.name}/#{image}"
    end

    def format_path(image)
      "#{Bricky.config.images}/#{image}"
    end
  end
end
