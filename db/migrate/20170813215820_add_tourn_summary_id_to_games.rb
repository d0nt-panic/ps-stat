class AddTournSummaryIdToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :tourn_summary_id, :integer, foreign_key: true, integer: true
  end
end
