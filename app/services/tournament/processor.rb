module Tournament
  class Processor
    def initialize(ts, user)
      @tourn_summary = ts
      @user = user
    end

    def call
      @tourn_summary.process!

      data_hash = Tournament::Parser(@tourn_summary.text_file.current_path, @user.nickname)
      data_hash[:tourn_summary_id] = @tourn_summary.id
      data_hash[:user_id] = @user.id
      game = GameValidator.new(data: data_hash)

      game ? @tourn_summary.success! : @tourn_summary.fail!
    # rescue ParsingError => e # or may be validations
    #   @tourn_summary.failure
    #   save_error(e.message)
    end

    # private

    # def save_error(error_message)
    #   @tourn_summary.update!(error_message: error_message)
    # end
  end
end
