module Tournament
  class ParseWorker
    include Sidekiq::Worker

    def perform(tourn_summary_id)
      tourn_summary = TournSummary.find(tourn_summary_id)
      Tournament::Processor.new(tourn_summary).call
    end
  end
end
