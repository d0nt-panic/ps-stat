module Tournament
  class LineParser
    def initialize(line, _opts = nil)
      @line = line
      @parse_result = nil
      @formatted_result = {}
    end

    def parse
      @parse_result = @line.match(pattern)
    end

    def formatted_result
      parse ? result_to_hash : empty_result_warn_log
      @formatted_result
    end

    private

    def result_to_hash
      @formatted_result.merge!(@parse_result.named_captures.symbolize_keys!)
    end

    def pattern
      raise NotImplementedError, 'Implement in child class'
    end

    def empty_result_warn_log
      Rails.logger.warn "#{@line}: empty string or mismatch"
    end
  end
end
