class ToursController < ApplicationController
  before_action :set_locale
  #protect_from_forgery except: :calendar

  def show
  	render layout: "unify"
  end

  def maoxian88
  	render layout: "unify"
  end

  def maoxian_vinery
  	render layout: "unify"
  end

  def au13
  	render layout: "unify-tour"
  end

  def west_au
  	render layout: "unify-tour"
  end

  def ax12
  	render "ax12_wx", layout: "unify-tour"
  end
  def ax13
  	render layout: "shijiebang"
  end

  def ax16
  	render layout: "unify-tour"
  end

  def sample
    render layout: "shijiebang"
  end

  def huang
    render layout: "shijiebang"
  end

  def round
    render layout: "shijiebang"
  end

  def calendar
    respond_to do |format|
      format.js {
        @departures = Departure.all
      }
    end
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
