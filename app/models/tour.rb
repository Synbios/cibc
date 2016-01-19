class Tour < ActiveRecord::Base
  has_attached_file :tour_map, styles: { standard: "600x600>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :tour_map, content_type: /\Aimage\/.*\Z/

  has_many :routes
  has_many :high_lights
  has_many :slides
end
