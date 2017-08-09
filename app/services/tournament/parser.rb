module Tournament
  class Parser
    attr_accessor :nickname, :file_path, :result

    PLACES_IN_PRIZES = 1

    def initialize(nickname, file_path)
      @nickname = nickname
      @file_path = file_path
      @result = {}
    end

    def call
      File.open(file_path).each.with_index do |line, line_number|
        begin
          parse_line(line_number, line)
        # rescue WrongUser
        #   next
        end
      end
      result.symbolize_keys!
      # TODO: write parsing
      # there will be parsing function code
      # result will save to data hash
      # may occur ParsingError
    end

    private

    def parse_line(line_number, line)
      parser = line_parser_for(line_number)
      match_result parser.new(line).parse
      result.merge!(match_result)
    end

    def line_parser_for(line_number)
      line_parsers[line_number] #|| Tournament::FindUserPlaceAndReward
    end

    def line_parsers
      {
        0 => Tournament::TourneyNumber,
        1 => Tournament::BuyinAndRake,
        2 => Tournament::Players,
        3 => Tournament::PrizePool,
        4 => Tournament::StartedAt
      }
    end
  end
end
