class ParseTournSummaryWorker
  include Sidekiq::Worker

  def perform(ts_id, user_id)
    ts = TournSummary.find(ts_id)
    user = User.find(user_id)
    Tournament::Processor.new(ts, user).call
  end
end
