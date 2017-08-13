module Tournament
  class Parser
    attr_accessor :nickname, :file_path, :result

    PLACES_IN_PRIZES = 1

    def initialize(file_path, nickname)
      @nickname = nickname
      @file_path = file_path
      @result = {}
    end

    def call
      File.open(file_path).each.with_index do |line, line_number|
        next if line == "\n"
        begin
          parse_line(line_number, line)
        rescue Parser::WrongUser
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
      parser = Tournament::LineParserRepository.line_parser_for(line_number)
      match_result = parser.new(line, nickname: nickname).parse
      result.merge!(match_result)
    end
  end
end
