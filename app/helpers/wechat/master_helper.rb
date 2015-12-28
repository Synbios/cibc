module Wechat::MasterHelper
  # 验证服务器签名
  def check_signature
    logger.info "CHECKING SIGNATURE #{params}"
    if params[:timestamp].nil? || params[:nonce].nil?
      render :text => "timestamp and nonce params missing ", :status => 403
    else
      array = [Rails.application.secrets.wechat_signature, params[:timestamp], params[:nonce]].sort
      render :text => "signature check failed", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
    end
  end

  # 为所有新访问用户创建账户
  # def check_account
  #   @account = Account.find_by(open_id: params[:xml][:FromUserName], server_open_id: GLOBAL["server_open_id"])
  #   Account.create(open_id: params[:xml][:FromUserName], server_open_id: GLOBAL["server_open_id"]) if @account.nil?
  # end


  # 获取微信 access_token
  # 返回 {"access_token"=>"15XhYAiZrgn9", "expires_in"=>7200} OR nil
  def wechat_get_access_token
    access_token = AccessToken.where("expires_at > ?", Time.now).order(:expires_at).last
    if access_token.present?
      access_token.key
    else
      uri = URI.parse Rails.application.secrets.access_token_url
      params = { grant_type: "client_credential", appid: Rails.application.secrets.appid, secret: Rails.application.secrets.appsecret }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        key = JSON.parse(res.body)["access_token"]
        access_token = AccessToken.create key: key, expires_at: Time.now+3600
        access_token.key
      else
        nil
      end
    end
  end

  def wechat_get_jsapi_ticket
    jsapi_ticket = JsapiTicket.where("expires_at > ?", Time.now).order(:expires_at).last
    if jsapi_ticket.present?
      jsapi_ticket.key
    else
      uri = URI.parse Rails.application.secrets.jsapi_ticket_url
      params = { access_token: wechat_get_access_token, type: "jsapi" }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        key = JSON.parse(res.body)["ticket"]
        jsapi_ticket = JsapiTicket.create key: key, expires_at: Time.now+3600
        jsapi_ticket.key
      else
        nil
      end
    end
  end

  def wechat_generate_jsapi_signature(input_url)
    noncestr = { key: "noncestr", value: ('a'..'z').to_a.shuffle.first(32).join }
    jsapi_ticket = { key: "jsapi_ticket", value: wechat_get_jsapi_ticket }
    timestamp = { key: "timestamp", value: Time.now.to_i.to_s }
    url = { key: "url", value: input_url.split('#')[0]}
    {
      noncestr: noncestr[:value],
      jsapi_ticket: jsapi_ticket[:value],
      timestamp: timestamp[:value],
      url: url[:value],
      signature: Digest::SHA1.hexdigest([noncestr, jsapi_ticket, timestamp, url].sort_by{ |h| h[:key] }.map{ |h| "#{h[:key]}=#{h[:value]}" }.join('&'))
    }
  end

  def send_wechat_text_message(open_id, message)
    access_token = wechat_get_access_token
    uri = URI.parse("#{ENV["send_message_url"]}?access_token=#{access_token["access_token"]}")
    req = Net::HTTP::Post.new uri
    req.body = {:touser => open_id, :msgtype => "text", :text => { :content => message } }.to_json
    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request req
    end

    JSON.parse res.body
  end

  def decode_gender(code)
    return "男" if code == 1
    return "女" if code == 2
    return "秘密"
  end

  def new_scan_notice(open_id)
    send_wechat_text_message(open_id, "您的二维码刚刚被扫描了")
  end

  ############## QR code section ###############

  # 获取2D码ticket
  def wechat_get_qr_code_ticket(id=1)
    access_token = wechat_get_access_token
    if access_token.present? && access_token["access_token"].present?
      access_token = access_token["access_token"]
    else
      return nil
    end
    data = Jbuilder.encode do |json|
      json.access_token access_token
      json.action_name "QR_LIMIT_SCENE"

      json.action_info do
        json.scene do
          json.scene_id id
        end
      
      end
    end

    # POST JSON to get ticket
    uri = URI.parse("#{GLOBAL["qr_code_ticket_url"]}?access_token=#{access_token}")
    req = Net::HTTP::Post.new uri
    req.body = {:action_name => 'QR_LIMIT_SCENE', :action_info => {:scene => { :scene_id => id }}}.to_json
    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request req
    end

    JSON.parse res.body
  end

  # 获取2D码图片
  def wechat_get_qr_code(id=1)
    ticket = wechat_get_qr_code_ticket(id)
    if ticket.present? && ticket["ticket"].present?
      ticket = ticket["ticket"]
    else
      return nil
    end
    uri = URI.parse GLOBAL["qr_code_show_url"]
    params = { :ticket => ticket }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    return res.body if res.is_a?(Net::HTTPSuccess)
    return nil
  end

  # 获取2D码URL
  def wechat_get_qr_code_url(id=1)
    ticket = wechat_get_qr_code_ticket(id)
    if ticket.present? && ticket["ticket"].present?
      ticket = ticket["ticket"]
      "#{GLOBAL["qr_code_show_url"]}?ticket=#{ticket}"
    else
      return nil
    end
  end
end