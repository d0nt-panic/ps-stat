class User
  class CreateNewForm < Dry::Struct
    constructor_type :schema

    attribute :nickname, Types::Coercible::String
    attribute :tourn_summaries, Types::Coercible::Array.default([])

    attr_reader :errors, :user

    def save
      validation = CreateFormSchema.call(to_hash)
      validation.success? ? process_form : return_errors(validation)
    end

    CreateFormSchema = Dry::Validation.Form do
      required(:nickname).filled
    end

    private

    def process_form
      @user = User.find_or_create_by(nickname: nickname)
      create_tourn_summaries
      @user
    end

    def return_errors(validation)
      @errors = validation.errors
      nil
    end

    def create_tourn_summaries
      tourn_summaries.each do |ts|
        ts_object = user.tourn_summaries.create!(text_file: ts)
        run_tourn_parser_worker(ts_object.id)
      end
    end

    def run_tourn_parser_worker(tourn_summary_id)
      Tournament::ParseWorker.perform_async(tourn_summary_id: tourn_summary_id)
    end
  end
end
