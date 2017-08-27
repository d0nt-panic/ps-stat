module Tournament
  module LineParsers
    class Repository
      class << self
        def line_parser_for(line_number)
          line_parsers[line_number] || Tournament::LineParsers::FindPlaceAndReward
        end

        def formatter_for(result)
          result.map { |k, v| [k, formatters(k, v)] }.to_h
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

        def formatters(key, value)
          case key
          when :tourney_number, :players, :place then value.to_i
          when :buy_in, :rake, :prize_pool, :reward then to_money(value)
          when :started_at then (DateTime.parse(value).utc + 4.hours) # TODO: fix this later
          else
            raise ArgumentError, "#{key} - unsupported type"
          end
        end

        def to_money(subject)
          (subject.to_f * 100).to_i
        end
      end
    end
  end
end
