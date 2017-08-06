class ParseTournSummaryWorker
  include Sidekiq::Worker

  def perform(ts_id)
    Tournament::Processor.new(ts_id).call
  end
end
