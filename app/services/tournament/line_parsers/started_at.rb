module Tournament
  module LineParsers
    class StartedAt < LineParser
      private

      def pattern
        /\[(?<started_at>.*)\]/
      end
    end
  end
end
