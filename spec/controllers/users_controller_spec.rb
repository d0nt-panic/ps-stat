require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do
    context 'with correct input' do
      subject do
        post :create, params: { user: { nickname: 'Foo' } }
      end

      it 'redirect to user page' do
        expect(subject).to redirect_to user_path(User.find_by(nickname: 'Foo'))
      end
    end

    context 'with incorrect input' do
      subject do
        post :create, params: { user: { nickname: '' } }
      end

      it 'redirect back' do
        expect(subject).to redirect_to new_user_path
      end
    end
  end

  describe '#show' do
    let(:user) { User.create(nickname: 'Fedor') }

    subject do
      get :show, params: { id: user.id }
    end

    it 'responce with 200' do
      subject
      expect(response).to have_http_status(:ok)
    end
  end
end
