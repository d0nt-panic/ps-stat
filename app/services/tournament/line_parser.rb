module Tournament
  class LineParser
    def initialize(line)
      @line = line
    end

    def parse
      @parse_result ||= @line.match(pattern).named_captures
    end

    def pattern
      raise NotImplementedError, 'Implement in child class'
    end
  end

  class TourneyNumber < LineParser
    private

    def pattern
      /№(?<tourney_number>\d+)/
    end
  end

  class BuyinAndRake < LineParser
    private

    def pattern
      /\$(?<buy_in>\d+\.\d+)\/\$(?<rake>\d+\.\d+)/
    end
  end

  class Players < LineParser
    private

    def pattern
      /(?<players>\d+)/
    end
  end

  class PrizePool < LineParser
    private

    def pattern
      /\$(?<prize_pool>\d+\.\d+)/
    end
  end

  class StartedAt < LineParser
    private

    def pattern
      /\[(?<started_at>.*)\]/
    end
  end

  class TourneyNumber < LineParser
    attr_accessor :user

    def parse
      super
      raise WrongUser unless @parse_result[:nickname] == user
      reward_result = if @parse_result[:place] <= Tournament::Parser::PlACES_IN_PRIZE
                        @line.match(reward_pattern).named_captures
                      else
                        { reward: '0,00' }
                      end
      @parse_result.merge!(reward_result)
    end

    private

    def pattern
      /(?<place>\d+): (?<nickname>\w+) .+\),/ 
    end

    def reward_pattern
      /\$(?<reward>\d+\,\d+)/
    end
  end
end
