class AddToTours < ActiveRecord::Migration
  def change
    add_column :tours, :wechat_share_title, :string
    add_column :tours, :wechat_share_description, :string
  end
end
