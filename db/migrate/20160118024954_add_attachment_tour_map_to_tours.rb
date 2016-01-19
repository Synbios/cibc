class AddAttachmentTourMapToTours < ActiveRecord::Migration
  def self.up
    change_table :tours do |t|
      t.attachment :tour_map
    end
  end

  def self.down
    remove_attachment :tours, :tour_map
  end
end
