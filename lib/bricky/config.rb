require "yaml"

module Bricky
  class Config 
    attr_accessor :name
    attr_accessor :images

    def from_yaml(file)
      config = YAML.load_file(file)
      self.name = config["bricky"]["name"]
      self.images = config["bricky"]["images"]
    end
  end
end
