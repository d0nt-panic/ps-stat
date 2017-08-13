module Tournament
  class LineParser
    def initialize(line, _opts = nil)
      @line = line
    end

    def parse
      @parse_result = @line.match(pattern).try(:named_captures) || {}
      @parse_result.symbolize_keys!
    end

    def pattern
      raise NotImplementedError, 'Implement in child class'
    end
  end
end
