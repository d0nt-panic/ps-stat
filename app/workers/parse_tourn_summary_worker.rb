class ParseTournSummaryWorker
  include Sidekiq::Worker

  def perform(ts_id, nickname)
    ts = TournSummary.find(ts_id)
    Tournament::Processor.new(ts, nickname).call
  end
end
