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

class TournSummary < ApplicationRecord
  include AASM

  mount_uploader :text_file, TournSummaryUploader

  belongs_to :user

  scope :without_errors, -> { where(error: nil) }

  aasm do
    state :new, initial: true
    state :processing
    state :error
    state :processed

    event :process do
      transitions from: [:new, :error], to: :processing
    end

    event :failure do
      transitions from: :processing, to: :error
    end

    event :success do
      transitions from: :processing, to: :processed
    end
  end
end
