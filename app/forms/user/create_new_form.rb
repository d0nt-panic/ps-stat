class User
  class CreateNewForm < Dry::Struct
    constructor_type :schema

    attribute :nickname, Types::Coercible::String
    attribute :tourn_summaries, Types::Coercible::Array.default([])

    attr_accessor :errors, :user

    def save!
      result = CreateFormSchema.call(to_hash)
      if result.success?
        self.user = User.find_or_create_by(nickname: nickname)
        create_tourn_summaries
        user
      else
        self.errors = result.errors
        nil
      end
    end

    CreateFormSchema = Dry::Validation.Form do
      required(:nickname).filled
      # required(:tourn_summaries).maybe
    end

    private

    def create_tourn_summaries
      tourn_summaries.each do |ts|
        ts_object = @user.tourn_summaries.create!(text_file: ts)
        run_tourn_parser_worker(ts_object.id, @user.id)
      end
    end

    def run_tourn_parser_worker(tourn_summary_id, user_id)
      ParseTournSummaryWorker.perform_async(ts_id: tourn_summary_id, user_id: user_id)
    end
  end
end
