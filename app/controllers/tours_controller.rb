class ToursController < ApplicationController
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
end
