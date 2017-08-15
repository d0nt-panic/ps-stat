class UsersController < ApplicationController
  def new
    # @user_create_form = User::CreateNewForm.new
  end

  def create
    create_form = User::CreateNewForm.new(user_params.to_h)

    if create_form.save!
      redirect_to user_path(create_form.user)
    else
      redirect_back fallback_location: new_user_path, notice: create_form.errors
    end
  end

  def show
    @user = User.find(params[:id])
  end

  # private

  def user_params
    params.require(:user).permit!
  end
end
