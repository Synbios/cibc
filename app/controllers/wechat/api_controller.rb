class Wechat::ApiController < ApplicationController
  include Wechat::MasterHelper

  #skip_before_filter :verify_authenticity_token if: :json_request? || :xml_request?
  protect_from_forgery with: :null_session
  before_filter :check_signature, :except => [:debug]

  # create new account for all new visitors
  #before_filter :check_account, :only => [:message]

  # 微信验证服务器前面接口
  def check
    render :text => params[:echostr]
  end

  # 接受所有微信来消息
  def message
    logger.info ">>> DEBUG >>> message type: POST #{params}"
    # default message contains empty string, which will be used to answer WeChat requests.
    # all requests must be answered within 5 seconds to prevent resending.
    @message = "该回复尚未设定"
    respond_to do |format|
      format.xml {
        if params[:xml][:FromUserName].present?
          logger.info "recived message from user client id = #{params[:xml][:FromUserName]}"
          # 获取用户信息
          # pull_client_info params[:xml][:FromUserName]
        end

        # 接收事件
        if params[:xml][:MsgType] == "event"
          # 关注/扫码事件
          if params[:xml][:Event] == "subscribe" || params[:xml][:Event] == "SCAN"

            # # 查找/新建用户 openid
            # wrecord = WechatRecord.find_or_create_by_openid_and_server_open_id(params[:xml][:FromUserName], GLOBAL["server_open_id"])
            # # 储存用户关注记录
            # follow = Follow.new
            # follow.server_open_id = GLOBAL["server_open_id"]
            # follow.openid = wrecord.openid
            # follow.action = params[:xml][:Event]
            

            # 扫描二维码引发关注
            if params[:xml][:EventKey].present?
              # event_id = params[:xml][:EventKey][/\d+/]
              # qr_code = QrCode.find_by(identifier: event_id, server_open_id: GLOBAL["server_open_id"])
              # logger.info ">>> DEBUG >>> FOLLOW"
              # if qr_code.present?
              #   logger.info ">>> DEBUG >>> FOLLOW BY SCAN QR CODE #{qr_code.id} by #{who}"
              #   follow.qr_code_id = qr_code.id
              #   AvatarAccountAndAccount.find_or_create_by(avatar_account_id: qr_code.account_id, account_id: who.id)
              #   who.update!(view_store_id: qr_code.avatar_account.store_id)
              #   begin
              #     send_wechat_text_message(Account.find_by(id: qr_code.account_id).open_id, "您的二维码刚才被关注了")
              #   rescue => e
                  
              #   end
              # end
            end
            #follow.save

            # 关注 - 回复感谢信息
            if params[:xml][:Event] == "subscribe"
              @message = "欢迎关注HeatList公众号。我们将为您提供加拿大专业的购房服务。"
              # logger.info render_to_string "message", :formats => :xml
              render  "message", :formats => :xml
            else

              render "message", :formats => :xml
            end
          # 取消关注事件
          elsif params[:xml][:Event] == "unsubscribe" 

            render "message", :formats => :xml

          # 用户上报地理位置 (进入对话时自动上报, 以后每5秒上报一次)
          elsif params[:xml][:Event] == "LOCATION"
            render "message", :formats => :xml
          
          # 用户点击菜单跳转链接
          elsif params[:xml][:Event] == "view" # 查看目录
            render "message", :formats => :xml
          
          # 用户点击菜单拉取消息
          elsif params[:xml][:Event] == "CLICK" 
            render "message", :formats => :xml
          end


        # 接收用户消息
        # 接收用户文字信息
        elsif params[:xml][:MsgType] == "text"
          
          # wmessage = WechatMessage.new
          # wmessage.open_id = params[:xml][:FromUserName]
          # wmessage.client_open_id = wmessage.open_id
          # wmessage.server_open_id = params[:xml][:ToUserName]
          # wmessage.msg_type = params[:xml][:MsgType]
          # wmessage.msg_id = params[:xml][:MsgId]
          # wmessage.content = Jbuilder.encode do |json|
          #   json.content params[:xml][:Content].chars.select{|i| i.valid_encoding?}.join
          # end
          # wmessage.save

          # logger.info render_to_string "message", :formats => :xml
          render "message", :formats => :xml

        # 接收用户图片信息
        elsif params[:xml][:MsgType] == "image"
          # 储存图片信息
          # wmessage = WechatMessage.new
          # wmessage.open_id = params[:xml][:FromUserName]
          # wmessage.server_open_id = params[:xml][:ToUserName]
          # wmessage.client_open_id = wmessage.open_id
          # wmessage.msg_type = params[:xml][:MsgType]
          # wmessage.msg_id = params[:xml][:MsgId]
          # wmessage.content = Jbuilder.encode do |json|
          #   json.pic_url params[:xml][:PicUrl]
          #   json.media_id params[:xml][:MediaId]
          # end
          # wmessage.save
          render "message", :formats => :xml

        # 接收用户语音信息
        elsif params[:xml][:MsgType] == "voice"
          render "message", :formats => :xml

        # 接收用户视频信息
        elsif params[:xml][:MsgType] == "video"
          render "message", :formats => :xml

        # 接收用户小视频信息
        elsif params[:xml][:MsgType] == "shortvideo"
          render "message", :formats => :xml

        # 接收用户地理位置信息
        elsif params[:xml][:MsgType] == "location"
          # wmessage = WechatMessage.new
          # wmessage.open_id = params[:xml][:FromUserName]
          # wmessage.server_open_id = params[:xml][:ToUserName]
          # wmessage.client_open_id = wmessage.open_id
          # wmessage.msg_type = params[:xml][:MsgType]
          # wmessage.msg_id = params[:xml][:MsgId]
          # wmessage.content = Jbuilder.encode do |json|
          #   json.location_x params[:xml][:Location_X]
          #   json.location_y params[:xml][:Location_Y]
          #   json.scale params[:xml][:Scale]
          #   json.label params[:xml][:Label]
          # end
          # wmessage.save
          # @message = "感谢您上传位置我们会尽快回复"
          render "message", :formats => :xml

        # 接收用户链接信息
        elsif params[:xml][:MsgType] == "link"
          # # 储存链接信息
          # wmessage = WechatMessage.new
          # wmessage.open_id = params[:xml][:FromUserName]
          # wmessage.server_open_id = params[:xml][:ToUserName]
          # wmessage.client_open_id = wmessage.open_id
          # wmessage.msg_type = params[:xml][:MsgType]
          # wmessage.msg_id = params[:xml][:MsgId]
          # wmessage.content = Jbuilder.encode do |json|
          #   json.title params[:xml][:Title]
          #   json.description params[:xml][:Description]
          #   json.url params[:xml][:Url]
          # end
          # wmessage.save
          # @message = "感谢您上传连接我们会尽快回复"
          render "message", :formats => :xml
        else
          @message = "Message type not supported."
          render "message", :formats => :xml
          logger.info "POST does not contain XML params = #{params}"
        end
      }
    end
  end

  private

  
end
