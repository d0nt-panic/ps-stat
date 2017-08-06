class ParseTournSummaryWorker
  include Sidekiq::Worker

  def perform(ts_id)
    TournSummaryProcessor.new(ts_id).call
  end
end
