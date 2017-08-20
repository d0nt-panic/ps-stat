class ParseTournSummaryWorker
  include Sidekiq::Worker

  def perform(tourn_summary_id)
    Tournament::Processor.build(tourn_summary_id).call
  end
end
