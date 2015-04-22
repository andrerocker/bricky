require "yaml"

module Bricky
  class Config 
    attr_accessor :project
    attr_accessor :package

    def from_yaml(file)
      config = YAML.load_file(file)["bricky"]
      self.project = OpenStruct.new(config["project"])
      self.package = OpenStruct.new(config["package"])
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
