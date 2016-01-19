class AddAttachmentImageToHighLights < ActiveRecord::Migration
  def self.up
    change_table :high_lights do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :high_lights, :image
  end
end
