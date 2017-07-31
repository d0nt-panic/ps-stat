# == Schema Information
#
# Table name: tourn_summaries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  text_files :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tourn_summaries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class TournSummary < ApplicationRecord
  mount_uploaders :text_files, TournSummaryUploader

  belongs_to :user
end
