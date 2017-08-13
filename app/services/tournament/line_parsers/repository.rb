module Tournament
  module LineParsers
    class Repository
      class << self
        def line_parser_for(line_number)
          line_parsers[line_number] || Tournament::LineParsers::FindPlaceAndReward
        end

        private

        def line_parsers
          {
            0 => Tournament::LineParsers::TourneyNumber,
            1 => Tournament::LineParsers::BuyinAndRake,
            2 => Tournament::LineParsers::Players,
            3 => Tournament::LineParsers::PrizePool,
            4 => Tournament::LineParsers::StartedAt
          }
        end
      end
    end
  end
end
