class Wechat::DaysController < ApplicationController

  def show
    respond_to do |format|
      format.js {
        @day = Day.find_by_id params[:id]
        @previous_day = @day.previous_day
        @next_day = @day.next_day
      }
    end
  end

end
  