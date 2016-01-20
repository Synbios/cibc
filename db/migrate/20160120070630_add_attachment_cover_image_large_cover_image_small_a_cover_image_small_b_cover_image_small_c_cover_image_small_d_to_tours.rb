class AddAttachmentCoverImageLargeCoverImageSmallACoverImageSmallBCoverImageSmallCCoverImageSmallDToTours < ActiveRecord::Migration
  def self.up
    change_table :tours do |t|
      t.attachment :cover_image_large
      t.attachment :cover_image_small_a
      t.attachment :cover_image_small_b
      t.attachment :cover_image_small_c
      t.attachment :cover_image_small_d
    end
  end

  def self.down
    remove_attachment :tours, :cover_image_large
    remove_attachment :tours, :cover_image_small_a
    remove_attachment :tours, :cover_image_small_b
    remove_attachment :tours, :cover_image_small_c
    remove_attachment :tours, :cover_image_small_d
  end
end
