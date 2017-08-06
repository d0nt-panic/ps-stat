# == Schema Information
#
# Table name: tourn_summaries
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  text_file     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  error_message :string
#  aasm_state    :string           not null
#
# Indexes
#
#  index_tourn_summaries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe TournSummary, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
