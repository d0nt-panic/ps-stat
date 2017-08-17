class GameValidator < Dry::Struct
  attribute :data, Types::Strict::Hash

  attr_accessor :errors

  def save!
    result = ValidationSchema.call(data)
    unless result.success?
      self.errors = result.errors
      return nil
    end

    game = Game.create(data)
    game
  end

  ValidationSchema = Dry::Validation.Form do
    required(:tourney_number).filled(:int?)
    required(:players).filled(:int?)
    required(:buy_in).filled(:int?)
    required(:rake).filled(:int?)
    required(:prize_pool).filled(:int?)
    required(:place).filled(:int?)
    required(:reward).filled(:int?)
    required(:started_at).filled(:time?)

    required(:user_id).filled(:int?)
    required(:tourn_summary_id).filled(:int?)
  end
end
