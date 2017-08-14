class GameValidator < Dry::Struct
  attribute :data, Types::Strict::Hash

  def save!
    result = ValidationSchema.call(data)
    return nil unless result.success? && data.delete(:nickname) == nickname

    game = Game.create(data)
    game
  end

  ValidationSchema = Dry::Validation.Form do
    required(:tourn_summaries).filled(:int?)
    required(:players).filled(:int?)
    required(:buy_in).filled(:int?)
    required(:rake).filled(:int?)
    required(:prize_pool).filled(:int?)
    required(:place).filled(:int?)
    required(:reward).filled(:int?)
    required(:started_at).filled(:date?)

    required(:user_id).filled(:int?)
    required(:tourn_summary_id).filled(:int?)
  end
end
