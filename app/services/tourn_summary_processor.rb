class TournSummaryProcessor
  # TODO: think about data format (attribute or not)
  attr_accessor :id, :data_hash

  def initialize(ts_id)
    id = ts_id
  end

  def call
    tourn_summary.process
    data_hash = TournParser(ts) # TODO: write class
    TournValidator(data_hash) # TODO: write class
    create_game
    tourn_summary.success
  rescue ParsingError, ValidationError => e # or may be validations
    tourn_summary.failure
    save_error(e.message)
  end

  private

  def create_game
    Game.create!(data_hash)
  end

  def save_error(error_message)
    tourn_summary.update(error_message: error_message)
  end

  def destroy_tourn_summary
    tourn_summary.destroy
  end

  def tourn_summary
    @tourn_summary ||= TournSummary.find(id)
  end
end
