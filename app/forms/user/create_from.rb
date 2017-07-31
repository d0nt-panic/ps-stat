module User
  module Types
    include Dry::Types.module
  end

  class CreateForm < Dry::Struct
    attribute :nickname, Types::Coercible::String
    attribute :tourn_summaries, Types::Coercible::Array

    attribute :id, Types::Coercible::Integer
    attribute :errors, Types::Coercible::Array

    def save
      result = CreateFormSchema.call(to_hash)

      if result.success?
        @user = User.find_or_create_by(nickname: nickname)
        @user.tourn_summaries.create(text_files: tourn_summaries)
        true
      else
        self.errors = result.errors
        false
      end
    end

    CreateFormSchema = Dry::Validation.Schema do
      required(:nickname).filled
      required(:tourn_summaries).filled
    end
  end
end

