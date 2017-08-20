module Tournament
  class Processor
    def self.build(tourn_summary_id)
      new(TournSummary.find(tourn_summary_id))
    end

    def initialize(ts)
      @tourn_summary = ts
      raise ArgumentError unless @tourn_summary.is_a?(TournSummary)

      @user = @tourn_summary.user
    end

    def call
      @tourn_summary.process!
      if @tourn_summary.text_file.current_path.nil?
        @tourn_summary.fail!
        return false
      end

      data_hash = create_data_hash
      game = GameValidator.new(data: data_hash)

      if game
        @tourn_summary.success!
        true
      else
        @tourn_summary.fail!
        @tourn_summary.error_message << game.errors.join(', ')
        false
      end
    end

    private

    def create_data_hash
      data_hash = Tournament::Parser.new(@tourn_summary.text_file.current_path, @user.nickname).call
      data_hash[:tourn_summary_id] = @tourn_summary.id
      data_hash[:user_id] = @user.id
      data_hash
    end
  end
end
