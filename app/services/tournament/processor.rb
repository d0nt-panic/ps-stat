module Tournament
  class Processor
    def initialize(ts)
      @tourn_summary = ts
      raise ArgumentError unless @tourn_summary.is_a?(TournSummary)

      @user = @tourn_summary.user
    end

    def call
      @tourn_summary.process!
      unless file_exist?
        @tourn_summary.fail_with_errors!(['file doesn\'t exist'])
        return nil
      end
      data_hash = parse_tournament_file
      game = GameValidator.new(data: data_hash)

      if game.save
        @tourn_summary.success!
      else
        @tourn_summary.fail_with_errors!(game.errors.to_a)
      end
    end

    private

    def file_exist?
      @tourn_summary.text_file.current_path.present?
    end

    def parse_tournament_file
      file_path = @tourn_summary.file_path
      nickname = @user.nickname
      data_hash = Tournament::Parser.new(file_path, nickname).call
      data_hash.merge(tourn_summary_id: @tourn_summary.id, user_id: @user.id)
    end
  end
end
