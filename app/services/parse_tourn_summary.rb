module Types
  include Dry::Types.module
end

class ParseTournSummary < Dry::Sturct
  attribute :id, Types::Strict::Int
  attribute :file_path, Types::Strict::String

  # TODO: think about data format (attribute or not)
  attr_accessor :data

  def call
    parse_file
    create_game
    destroy_tourn_summary
    # TODO: think about error handling
  rescue ParsingError => e # or may be validations
    save_error(e.message)
  end

  private

  def parse_file
    File.open(file_path) do |f|
      # TODO: write parsing
      # there will be parsing function code
      # result will save to data hash
      # may occur ParsingError
    end
  end

  def create_game
    # TODO: think how to add user_id
    Game.create(data)
  end

  def save_error(error_message)
    TournSummary.find(id).update(error: error_message)
  end

  def destroy_tourn_summary
    TournSummary.find(id).destroy
  end
end
