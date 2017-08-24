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
          match_result = parse_line(line_number, line)
          @result.merge!(match_result)
        rescue Tournament::Parser::WrongUserException => e
          Rails.logger.warn e
          next
        end
      end
      @result.symbolize_keys!
      format_result
      @result
    end

    private

    def parse_line(line_number, line)
      parser = Tournament::LineParsers::Repository.line_parser_for(line_number)
      parser.new(line, nickname: nickname).formatted_result
    end

    def format_result
      @result = Tournament::LineParsers::Repository.formatter_for(@result)
    end
  end
end
