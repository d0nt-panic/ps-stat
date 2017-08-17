module Tournament
  class Processor
    def initialize(ts, user)
      @tourn_summary = ts
      @user = user
    end

    def call
      @tourn_summary.process!
      p @tourn_summary.aasm_state
      @tourn_summary.fail! && return if @tourn_summary.text_file.current_path.nil?

      data_hash = create_data_hash
      game = GameValidator.new(data: data_hash)

      if game
        @tourn_summary.success!
      else
        @tourn_summary.fail!
        @tourn_summary.error_message << game.errors.join(', ')
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
