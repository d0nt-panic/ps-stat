require 'rails_helper'

RSpec.describe User::CreateNewForm do
  describe '#save!' do
    context 'if success' do
      let(:valid_form) { User::CreateNewForm.new(nickname: 'Foo') }

      it 'return true' do
        expect(valid_form.save!).to be_an_instance_of(User)
      end

      it 'create user' do
        valid_form.save!
        expect(User.count).to eq 1
      end

      # it '#errors be nil' do
      # end
    end

    context 'if failure' do
      let(:invalid_form) { User::CreateNewForm.new(nickname: '') }

      it 'return false' do
        expect(invalid_form.save!).to be nil
      end

      # it '#errors not nil' do
      #   user_form = create_form
      #   user_form.save!
      #   expect(user_form.errors).not_to be nil
      # end
    end
  end
end
