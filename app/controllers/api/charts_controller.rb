module Api
  class ChartsController < ApplicationController
    def games_summary
      @user = User.find(params[:user_id])

      total_profit = 0
      result = @user.games.order_by(:started_at).map do |g|
        total_profit += g.current_profit
        total_profit
      end
      render json: [{ name: 'All Games', data: result }]
    end
  end
end
