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
  has_many :games
end
