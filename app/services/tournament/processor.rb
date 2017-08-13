module Tournament
  class Processor
    # TODO: think about data format (attribute or not)
    # attr_accessor :id, :data_hash

    def initialize(ts, nickname)
      @tourn_summary = ts
      @nickname = nickname
    end

    def call
      @tourn_summary.process
      data_hash = Tournament::Parser(@tourn_summary.text_file.current_path, @nickname)
      validation_result = GameValidator(data_hash) # TODO: write class
      # create_game
      # validation_result.success? ? @tourn_summary.success : @tourn_summary.failure
    rescue ParsingError => e # or may be validations
      @tourn_summary.failure
      save_error(e.message)
    end

    private

    def create_game
      Game.create!(data_hash)
    end

    def save_error(error_message)
      tourn_summary.update!(error_message: error_message)
    end

    def destroy_tourn_summary
      tourn_summary.destroy
    end

    def tourn_summary
      @tourn_summary ||= TournSummary.find(id)
    end
  end
end
