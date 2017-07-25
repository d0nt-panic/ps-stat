# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nickname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:games).dependent(:destroy) }
  end
end
