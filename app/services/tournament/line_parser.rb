module Tournament
  class LineParser
    def initialize(line, nickname)
      @line = line
      @nickname = nickname
      @parse_result = nil
    end

    def parse
      @parse_result = @line.match(pattern).try(:named_captures) || {}
    end

    def pattern
      raise NotImplementedError, 'Implement in child class'
    end
  end
end
