class Wechat::MasterController < ApplicationController
  include Wechat::SessionsHelper
  include Wechat::MasterHelper

  before_action :authenticate_openid!, except: [:wechat_get_open_id_error]
  before_action :wechat_sign_in, except: [:wechat_get_open_id_error]

  def wechat_get_open_id_error
  end

end
