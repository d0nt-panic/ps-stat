class User
  module Types
    include Dry::Types.module
  end

  class CreateNewForm < Dry::Struct
    constructor_type :schema

    attribute :nickname, Types::Coercible::String
    attribute :tourn_summaries, Types::Coercible::Array

    attr_accessor :id, :errors

    def save!
      result = CreateFormSchema.call(to_hash)
      if result.success?
        user = User.find_or_create_by(nickname: nickname)
        self.id = user.id
        if tourn_summaries
          tourn_summaries.each do |ts|
            user.tourn_summaries.create(text_file: ts)
          end
        end
        true
      else
        self.errors = result.errors
        false
      end
    end

    CreateFormSchema = Dry::Validation.Form do
      required(:nickname).filled
      required(:tourn_summaries).maybe
    end
  end
end
