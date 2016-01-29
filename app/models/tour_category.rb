class TourCategory < ActiveRecord::Base
  has_attached_file :icon, styles: { standard: "150x150>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/
end
