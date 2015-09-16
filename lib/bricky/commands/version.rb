module Bricky
  module Commands
    class Version < Base
      def execute
        logger.important "Bricky:", " A smart way to build software packages"
        logger.info <<EOF
     --------------------------
    | v#{Bricky::VERSION} - #{Bricky::CODENAME} |
     -------------------------
            \\   ^__^
             \\  (oo)\_______
                (__)\       )\\/\\/
                    ||----w |
                    ||     ||
EOF
      end
    end
  end
end
