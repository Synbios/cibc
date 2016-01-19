class Wechat::DeparturesController < ApplicationController
  before_action :set_locale

  def index
    @route = Route.find_by_id params[:route_id]
    @departures = @route.departures
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
end