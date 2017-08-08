module Tournament
  class Parser
    attr_accessor :result
    attr_accessor :nickname, :file_path

    def initialize(nickname, file_path)
      self.nickname = nickname
      self.file_path = file_path
      self.result = {}
    end

    def call
      File.open(file_path).each.with_index do |line, i|
        case i
        when 0 then tourney_number(line)
        when 1 then buyin_and_rake(line)
        when 2 then players(line)
        when 3 then prize_pool(line)
        when 4 then started_at(line)
        # else
        #   find_user_place_and_reward(line)
        end
        # TODO: write parsing
        # there will be parsing function code
        # result will save to data hash
        # may occur ParsingError
      end
      result.symbolize_keys!
    end

    private

    def tourney_number(line)
      match_result = line.match(/№(?<tourney_number>\d+)/).named_captures
      result.merge!(match_result)
    end

    def buyin_and_rake(line)
      match_result = line.match(/\$(?<buy_in>\d+\.\d+)\/\$(?<rake>\d+\.\d+)/).named_captures
      result.merge!(match_result)
    end

    def players(line)
      match_result = line.match(/(?<players>\d+)/).named_captures
      result.merge!(match_result)
    end

    def prize_pool(line)
      match_result = line.match(/\$(?<prize_pool>\d+\.\d+)/).named_captures
      result.merge!(match_result)
    end

    def started_at(line)
      match_result = line.match(/\[(?<started_at>.*)\]/).named_captures
      result.merge!(match_result)
    end

    # def find_user_place_and_reward(line)
    #   match_result = line.match(/(?<place>\d+): (?<nickname>\w+) .+\), \$(?<reward>\d+\,\d+)/).named_captures
    #   result.merge!(match_result) if match_result[:nickname] == nickname
    # end
  end
end
