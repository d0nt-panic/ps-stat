# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nickname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :tourn_summaries, dependent: :destroy

  # def self.create_form_schema
  #   Dry::Validation.Schema do
  #     required(:nickname).filled
  #     required(:tourn_summaries).filled
  #   end
  # end
end
