class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :tourney_number
      t.integer :players
      t.integer :buy_in
      t.integer :rake
      t.integer :prize_pool
      t.integer :place
      t.integer :reward, default: 0
      t.datetime :started_at

      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
