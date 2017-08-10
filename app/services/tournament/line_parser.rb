module Tournament
  class LineParser
    def initialize(line, _opts)
      @line = line
    end

    def parse
      @parse_result = @line.match(pattern).try(:named_captures) || {}
    end

    def pattern
      raise NotImplementedError, 'Implement in child class'
    end
  end
end
