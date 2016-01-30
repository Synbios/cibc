class AddAttachmentWechatShareIconToTours < ActiveRecord::Migration
  def self.up
    change_table :tours do |t|
      t.attachment :wechat_share_icon
    end
  end

  def self.down
    remove_attachment :tours, :wechat_share_icon
  end
end
