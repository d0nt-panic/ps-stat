module Tournament
  module LineParsers
    class PrizePool < LineParser
      private

      def pattern
        /\$(?<prize_pool>\d+\.\d+)/
      end
    end
  end
end
