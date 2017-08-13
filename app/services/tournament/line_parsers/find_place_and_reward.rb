module Tournament
  module LineParsers
    class FindPlaceAndReward < LineParser
      def initialize(line, opts)
        super
        @nickname = opts[:nickname]
      end

      def parse
        super
        wrong_user_error
        reward_result = if @parse_result[:place].to_i <= Tournament::Parser::PLACES_IN_PRIZES
                          @line.match(reward_pattern).try(:named_captures) || {}
                        else
                          { reward: '0,00' }
                        end
        reward_result.symbolize_keys!
        @parse_result.merge!(reward_result)
      end

      private

      def pattern
        /(?<place>\d+): (?<nickname>\w+) .+\),/
      end

      def reward_pattern
        /\$(?<reward>\d+\,\d+)/
      end

      def wrong_user_error
        raise ::Parser::WrongUser unless @parse_result[:nickname] == @nickname
      end
    end
  end
end
