module Bricky
  module Commands
    class Version < Base
      def execute
        logger.important "Bricky Version: ", Bricky::VERSION
      end
    end
  end
end
