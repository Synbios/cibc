class AddAttachmentIconToTourCategories < ActiveRecord::Migration
  def self.up
    change_table :tour_categories do |t|
      t.attachment :icon
    end
  end

  def self.down
    remove_attachment :tour_categories, :icon
  end
end
