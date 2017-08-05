# == Schema Information
#
# Table name: tourn_summaries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  text_file  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  error      :string
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
  mount_uploader :text_file, TournSummaryUploader

  belongs_to :user

  scope :without_errors, -> { where(error: nil) }
end
