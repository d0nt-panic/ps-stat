class AddTournSummariesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tourn_summaries, :json
  end
end
