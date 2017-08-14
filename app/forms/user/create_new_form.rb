class User
  class CreateNewForm < Dry::Struct
    constructor_type :schema

    attribute :nickname, Types::Coercible::String
    attribute :tourn_summaries, Types::Coercible::Array

    attr_accessor :errors

    def save!
      result = CreateFormSchema.call(to_hash)
      if result.success?
        user = User.find_or_create_by(nickname: nickname)
        if tourn_summaries
          tourn_summaries.each do |ts|
            ts_object = user.tourn_summaries.create!(text_file: ts)
            run_tourn_summary_worker(ts_object.id, user.id)
          end
        end
        user
      else
        self.errors = result.errors
        nil
      end
    end

    CreateFormSchema = Dry::Validation.Form do
      required(:nickname).filled
      required(:tourn_summaries).maybe
    end

    private

    def run_tourn_summary_worker(ts_id, u_id)
      ParseTournSummaryWorker.perform_async(ts_id: ts_id, user_id: u_id)
    end
  end
end
