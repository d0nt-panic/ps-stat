# == Schema Information
#
# Table name: games
#
#  id             :integer          not null, primary key
#  tourney_number :integer
#  players        :integer
#  buy_in         :integer
#  rake           :integer
#  prize_pool     :integer
#  place          :integer
#  reward         :integer          default(0)
#  started_at     :datetime
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_games_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end
end
