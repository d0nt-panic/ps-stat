class UsersController < ApplicationController
  def new
  end

  def create
    result = User.create_form_schema.call(user_params)

    if result.success?
      @user = User.create(user_params)
      redirect_to user_path(@user)
    else
      redirect_back fallback_location: new_user_path, notice: result.errors
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:nickname, tourn_summaries: [])
  end
end
