class AddAttachmentContentImageToTours < ActiveRecord::Migration
  def self.up
    change_table :tours do |t|
      t.attachment :content_image
    end
  end

  def self.down
    remove_attachment :tours, :content_image
  end
end
