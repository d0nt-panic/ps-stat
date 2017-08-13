module Tournament
  module LineParsers
    class Players < LineParser
      private

      def pattern
        /(?<players>\d+)/
      end
    end
  end
end
