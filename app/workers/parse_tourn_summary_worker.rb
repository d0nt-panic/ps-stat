class ParseTournSummaryWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(user_id)
    user.tourn_summaries.without_errors.each do |ts|
      ParseTournSummary.new(id: ts.id, file_path: ts.text_file.current_path).call
    end
  end
end
