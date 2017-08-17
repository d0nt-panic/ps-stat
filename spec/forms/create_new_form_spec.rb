require 'rails_helper'

RSpec.describe User::CreateNewForm do
  describe '#save!' do
    context 'if success' do
      let(:valid_form) { User::CreateNewForm.new(nickname: 'Foo') }

      it 'return user' do
        expect(valid_form.save!).to be_an_instance_of(User)
      end

      it 'create user' do
        valid_form.save!
        expect(User.count).to eq 1
      end
    end

    context 'if failure' do
      let(:invalid_form) { described_class.new(nickname: '') }
      subject { invalid_form.save! }

      it 'return false' do
        expect(subject).to be nil
      end

      it '#errors not nil' do
        subject
        expect(invalid_form.errors).not_to be nil
      end
    end
  end
end
