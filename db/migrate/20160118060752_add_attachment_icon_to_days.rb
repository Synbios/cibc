class AddAttachmentIconToDays < ActiveRecord::Migration
  def self.up
    change_table :days do |t|
      t.attachment :icon
    end
  end

  def self.down
    remove_attachment :days, :icon
  end
end
