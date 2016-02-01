class AddAttachmentImageToShards < ActiveRecord::Migration
  def self.up
    change_table :shards do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :shards, :image
  end
end
