class Wechat::TourAvatorsController < ApplicationController
  include Wechat::MasterHelper

  def show
    @domain_url = "www.jhtwork.com"
    @tour = TourAvator.find_by_id params[:id]
    @shards = @tour.shards.order(:order)
    @wx_signature = wechat_generate_jsapi_signature request.url
    render layout: "shijiebang"
  end

end
