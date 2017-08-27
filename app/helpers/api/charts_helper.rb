module Api
  module ChartsHelper
    def games_summary_chart
      line_chart games_summary_api_charts_path(user_id: @user.id), library: {
        title: { text: 'Profit' },
        yAxis: {
          crosshair: true,
          title: { text: 'Profit value' }
        },
        xAxis: {
          crosshair: true,
          title: { text: 'Number of games' }
        }
      }
    end
  end
end
