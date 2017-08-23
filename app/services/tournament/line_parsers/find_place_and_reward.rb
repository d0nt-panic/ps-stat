module Tournament
  module LineParsers
    class FindPlaceAndReward < LineParser
      def initialize(line, opts)
        super
        @nickname = opts[:nickname]
      end

      private

      def pattern
        /(?<place>\d+): (?<nickname>\w+) .+\), (\$(?<reward>\d+\,\d+))*/
      end

      def result_to_hash
        super
        raise_wrong_user_error! unless @parse_result[:nickname] == @nickname
        @parse_result.delete(:nickname)
        @parse_result[:reward] ||= '0,00'
      end

      def raise_wrong_user_error!
        Rails.logger.error "#{@line}: found #{@parse_result[:nickname]} expected #{@nickname}"
        raise Tournament::Parser::WrongUserException
      end
    end
  end
end
