module Bricky
  module Commands
    class Version < Base
      def execute
        logger.important "Bricky Version: ", Bricky::VERSION
        logger.important "Codename: ", Bricky::CODENAME
      end
    end
  end
end
