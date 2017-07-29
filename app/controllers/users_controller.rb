class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      head :bad_request
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
