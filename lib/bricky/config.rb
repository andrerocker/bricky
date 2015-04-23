require "yaml"

module Bricky
  class Config 
    attr_accessor :name
    attr_accessor :images
    attr_accessor :bricks

    def from_yaml(file)
      config = YAML.load_file(file)["bricky"]

      self.name = config["name"]
      self.images = config["images"]
      self.bricks = config["bricks"]
    end

    def full_scripts_path
      File.expand_path("#{base_path}/bricky/containers/scripts", __FILE__)
    end

    private
      def base_path
        "../../.."
      end
  end
end
