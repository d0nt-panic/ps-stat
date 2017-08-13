module Tournament
  module LineParsers
    class TourneyNumber < LineParser
      private

      def pattern
        /№(?<tourney_number>\d+)/
      end
    end
  end
end
