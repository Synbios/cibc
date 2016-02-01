class Wechat::ToursController < ApplicationController
  include Wechat::MasterHelper

  def show
    @domain_url = "www.jhtwork.com"
    @tour_avator = TourAvator.find_by_id params[:id]
    @shards = @tour_avator.shards
    @wx_signature = wechat_generate_jsapi_signature request.url
    render layout: "shijiebang"
  end

end
