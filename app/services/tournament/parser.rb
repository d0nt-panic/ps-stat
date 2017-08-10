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
        next if line == "\n"
        begin
          parse_line(line_number, line)
        rescue WrongUser
          next
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
      match_result = parser.new(line, nickname: nickname).parse
      result.merge!(match_result)
    end

    def line_parser_for(line_number)
      line_parsers[line_number] || Tournament::LineParsers::FindPlaceAndReward
    end

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
