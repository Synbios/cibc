class Wechat::ToursController < ApplicationController
  include Wechat::MasterHelper

  def index
  end

  def show
    @domain_url = "www.jhtcd.com"
    @wx_signature = wechat_generate_jsapi_signature request.url
    render "tours/huang", layout: "shijiebang"
  end
end
