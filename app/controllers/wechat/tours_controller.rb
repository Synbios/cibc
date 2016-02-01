class Wechat::ToursController < ApplicationController
  include Wechat::MasterHelper

  def index
    @tour_categories = TourCategory.limit(8).order(:order)
    @tour_category = TourCategory.find_by_id(params[:tour_category_id])
    if @tour_category.present?
      @tours = Tour.joins(:tour_categories).where("tours.order > ? AND tour_categories.id = ?", 0, @tour_category.id).order(:order)
     else
      @tours = Tour.where("tours.order > ? AND tours.active = ? AND tours.type is NULL", 0, 1).order(:order)
    end
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
