class AddErrorToTournSummaries < ActiveRecord::Migration[5.1]
  def change
    add_column :tourn_summaries, :error, :string, default: nil
  end
end
