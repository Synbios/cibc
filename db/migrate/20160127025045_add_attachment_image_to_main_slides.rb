class AddAttachmentImageToMainSlides < ActiveRecord::Migration
  def self.up
    change_table :main_slides do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :main_slides, :image
  end
end
