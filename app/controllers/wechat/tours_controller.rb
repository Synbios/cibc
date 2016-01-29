class Wechat::ToursController < ApplicationController
  include Wechat::MasterHelper

  def index
  	@tour_categories = TourCategory.limit(8).order(:order)
  	@tour_category = TourCategory.find_by_id(params[:tour_category_id])
  	@tours = Tour.where("tours.order > ?", 0).order(:order)
  	@main_slides = MainSlide.where(active: true)
  	@wx_signature = wechat_generate_jsapi_signature request.url
    render layout: "shijiebang"
  end

  def show
    @domain_url = "www.jhtwork.com"
    @tour = Tour.find_by_id params[:id]
    @routes = @tour.routes
    @this_month = Time.now
    @next_month = @this_month + 1.month
    @next_next_month = @this_month + 2.month
    @wx_signature = wechat_generate_jsapi_signature request.url
    render layout: "shijiebang"
  end
end
