class Day < ActiveRecord::Base
  has_attached_file :icon, styles: { thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/

  belongs_to :previous_day, class_name: "Day", foreign_key: :previous_day_id
  belongs_to :next_day, class_name: "Day", foreign_key: :next_day_id
  belongs_to :route
end
