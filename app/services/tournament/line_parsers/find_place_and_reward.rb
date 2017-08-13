module Tournament
  module LineParsers
    class FindPlaceAndReward < LineParser
      def initialize(line, opts)
        super
        @nickname = opts[:nickname]
      end

      def parse
        super
        raise ::Parser::WrongUser unless @parse_result['nickname'] == @nickname
        reward_result = if @parse_result['place'].to_i <= Tournament::Parser::PLACES_IN_PRIZES
                          @line.match(reward_pattern).named_captures
                        else
                          { reward: '0,00' }
                        end
        @parse_result.merge!(reward_result)
      end

      private

      def pattern
        /(?<place>\d+): (?<nickname>\w+) .+\),/
      end

      def reward_pattern
        /\$(?<reward>\d+\,\d+)/
      end
    end
  end
end
