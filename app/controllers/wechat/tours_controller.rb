class Wechat::ToursController < ApplicationController
  include Wechat::MasterHelper

  def index
    render layout: "shijiebang"
  end

  def show
    @domain_url = "www.jhtwork.com"
    @wx_signature = wechat_generate_jsapi_signature request.url
    render "#{params[:id]}", layout: "shijiebang"
  end
end
