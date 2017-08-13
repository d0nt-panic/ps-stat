class Game
  module Types
    include Dry::Types.module
  end

  class GameValidator < Dry::Struct
    attribute :data, Types::Strict::Hash
    attribute :nickname, Types::Strict::String

    def save!
      result = ValidationSchema.call(data)
      return nil unless result.success? && data.delete(:nickname) == nickname

      Game.create(data)
    end

    ValidationSchema = Dry::Validation.Form do
      # required(:nickname).filled(:string?)
      required(:tourn_summaries).filled(:int?)
      required(:players).filled(:int?)
      required(:buy_in).filled(:int?)
      required(:rake).filled(:int?)
      required(:prize_pool).filled(:int?)
      required(:place).filled(:int?)
      required(:reward).filled(:int?)
      required(:started_at).filled(:date?)
    end
  end
end
