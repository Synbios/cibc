module Wechat::SessionsHelper
  
  # 微信端(open_id)登录, 并创建新账号。如无openid则返回nil
  def wechat_sign_in
    logger.info ">>> USER OPEN ID SIGN IN (OPEN ID = #{session[:open_id]}) <<<"

    # return if already logged in
    return @user if @user.present?

    # login as default (test user) if open_id is missing
    return @user = Account.getTestUser if session[:open_id].blank?
    
    @user = Account.find_by(open_id: session[:open_id])
    

    # create new account for new open_id
    if @user.nil?
      logger.info "CANNOT FIND OPEN ID = #{session[:open_id]} WILL CREATE IT"
      @user = Account.create open_id: session[:open_id]
    end
    logger.info "LOGGED IN AS ID = #{@user.id}"
    return @user
  end

  # 微信端登出
  def wechat_sign_out
    @user = nil
    session.delete(:open_id)
  end

  def authenticate_openid!
    # 只有在高级接口开放和openid为空时引导
    logger.info "AUTHENTICATION OPEN ID FUNCTION CALLED #{request.url}"
    if ENV["RAILS_ENV"] == "production" && session[:open_id].blank?
      
      code = params[:code]

      # 如果code参数为空，则为认证第一步，重定向到微信认证
      if code.nil?
        redirect_to "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{Rails.application.secrets.appid}&redirect_uri=#{request.url}&response_type=code&scope=snsapi_base&state=0#wechat_redirect"
        return
      end

      logger.info "CODE = #{code} STEP 2 url = #{request.url}"
      #如果code参数不为空，则认证到第二步，通过code获取open_id，并保存到session中
      begin
        url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Rails.application.secrets.appid}&secret=#{Rails.application.secrets.appsecret}&code=#{code}&grant_type=authorization_code"
        response = URI.parse(url).read
        logger.info "+++++++++++ code = '#{code}' #{response} +++++++++++++"
        session[:open_id] = JSON.parse(response)["openid"]
      rescue Exception => e
        logger.info "警告: CODE #{code} 换取 OPEN ID 失败"
      end
    end
    logger.info "AUTH OPEN ID = #{session[:open_id]}"
  end

  # # 进一步读取用户详细信息到session
  # def authenticate_allinfo!
  #   # heatlist 暂时不使用改接口
  #   if false
  #     # 当session中没有access_token时，则为非授权状态
  #     if session[:access_token].blank? || session[:nickname].blank?
  #       code = params[:code]
  #       state = params[:state]

  #       # 如果code参数为空，则有2种可能： 1. 用户尚未认证； 2. 用户拒绝认证
  #       if code.nil?
  #         # state 参数为空，做第一步认证
  #         if state.nil?
  #           redirect_to "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{ENV["app_id"]}&redirect_uri=#{request.url}&response_type=code&scope=snsapi_userinfo&state=step1#wechat_redirect"
  #         else
  #           # 用户拒绝提供详细信息，授权结束
  #           return
  #         end
  #         return
  #       end

  #       #如果code参数不为空，则用户同意授权，认证到第二步，通过code获取access_token ，并保存到session中
  #       begin
  #         url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{ENV["app_id"]}&secret=#{ENV["app_secret"]}&code=#{code}&grant_type=authorization_code"
  #         res = JSON.parse(URI.parse(url).read)
  #         session[:access_token] = res["access_token"]
  #         session[:open_id] = res["openid"]
  #         #拉取用户信息
  #         url = "https://api.weixin.qq.com/sns/userinfo?access_token=#{res["access_token"]}&openid=#{res["openid"]}&lang=zh_CN"
  #         #logger.info url
  #         res = JSON.parse(URI.parse(url).read)
  #         #logger.info res
  #         session[:nickname] = res["nickname"]
  #         session[:sex] = res["sex"]
  #         session[:city] = res["city"]
  #         session[:country] = res["country"]
  #         session[:headimgurl] = res["headimgurl"]
  #         session[:province] = res["province"]
  #         # update user info
  #         if session[:openid].present?
  #           #record = WechatRecord.find_or_create_by_openid_and_server_open_id(session[:open_id], GLOBAL["server_open_id"])
  #           record.nickname = session[:nickname]
  #           record.nickname = record.nickname.chars.select{|i| i.valid_encoding?}.join if record.nickname.present?
  #           record.sex = session[:sex]
  #           record.city = session[:city]
  #           record.country = session[:country]
  #           record.headimgurl = session[:headimgurl]
  #           record.province = session[:province]
  #           record.save
  #         end
  #       rescue Exception => e
  #         # ... 
  #       end
  #     end

  #   end
  # end

  # 获取2D码ticket
  # def wechat_get_qr_code_ticket(id=1)
  #   access_token = wechat_get_access_token
  #   if access_token.present? && access_token["access_token"].present?
  #     access_token = access_token["access_token"]
  #   else
  #     return nil
  #   end
  #   data = Jbuilder.encode do |json|
  #     json.access_token access_token
  #     json.action_name "QR_LIMIT_SCENE"

  #     json.action_info do
  #       json.scene do
  #         json.scene_id id
  #       end
      
  #     end
  #   end

  #   # POST JSON to get ticket
  #   uri = URI.parse("#{GLOBAL["qr_code_ticket_url"]}?access_token=#{access_token}")
  #   req = Net::HTTP::Post.new uri
  #   req.body = {:action_name => 'QR_LIMIT_SCENE', :action_info => {:scene => { :scene_id => id }}}.to_json
  #   res = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
  #     http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  #     http.ssl_version = :SSLv3
  #     http.request req
  #   end

  #   JSON.parse res.body
  # end

  # 获取2D码图片
  # def wechat_get_qr_code(id=1)
  #   ticket = wechat_get_qr_code_ticket(id)
  #   if ticket.present? && ticket["ticket"].present?
  #     ticket = ticket["ticket"]
  #   else
  #     return nil
  #   end
  #   uri = URI.parse GLOBAL["qr_code_show_url"]
  #   params = { :ticket => ticket }
  #   uri.query = URI.encode_www_form(params)
  #   res = Net::HTTP.get_response(uri)
  #   return res.body if res.is_a?(Net::HTTPSuccess)
  #   return nil
  # end

  # # 获取2D码URL
  # def wechat_get_qr_code_url(id=1)
  #   ticket = wechat_get_qr_code_ticket(id)
  #   if ticket.present? && ticket["ticket"].present?
  #     ticket = ticket["ticket"]
  #     "#{GLOBAL["qr_code_show_url"]}?ticket=#{ticket}"
  #   else
  #     return nil
  #   end
  # end

  # 获取用户基本信息
  # def pull_client_info(openid)
  #   access_token = wechat_get_access_token
  #   logger.info ">>>>>>>>>>>> #{access_token["access_token"]}"
  #   if !access_token.blank?
  #     url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=#{access_token["access_token"]}&openid=#{openid}&lang=zh_CN"
  #     logger.info ">>>>>>>>>>>>>> #{url}"
  #     res = JSON.parse(URI.parse(url).read)
  #     client = WechatRecord.find_or_create_by_openid_and_server_open_id(openid, GLOBAL["server_open_id"])
  #     client.nickname = res["nickname"] if res["nickname"].present?
  #     client.sex = res["sex"] if res["sex"].present?
  #     client.country = res["country"] if res["country"].present?
  #     client.province = res["province"] if res["province"].present?
  #     client.headimgurl = res["headimgurl"] if res["headimgurl"].present?
  #     begin
  #       client.save
  #     rescue
  #       client.nickname = "非法用户名"
  #       client.save
  #     end

  #   end
  # end

end
