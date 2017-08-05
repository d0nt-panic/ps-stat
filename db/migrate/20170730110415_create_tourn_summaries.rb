class CreateTournSummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :tourn_summaries do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :text_file

      t.timestamps
    end
  end
end
