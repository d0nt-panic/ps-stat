# == Schema Information
#
# Table name: games
#
#  id               :integer          not null, primary key
#  tourney_number   :integer
#  players          :integer
#  buy_in           :integer
#  rake             :integer
#  prize_pool       :integer
#  place            :integer
#  reward           :integer          default(0)
#  started_at       :datetime
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tourn_summary_id :integer
#
# Indexes
#
#  index_games_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Game < ApplicationRecord
  belongs_to :tourn_summary
  belongs_to :user

  def total_buy_in
    buy_in + rake
  end

  def current_profit
    reward - total_buy_in
  end
end
