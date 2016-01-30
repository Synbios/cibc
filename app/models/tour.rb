class Tour < ActiveRecord::Base

  has_attached_file :tour_map, styles: { standard: "600x600>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :tour_map, content_type: /\Aimage\/.*\Z/

  has_attached_file :cover_image_large, styles: { medium: '375x250>', thumb: '100x100#' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover_image_large, content_type: /\Aimage\/.*\Z/

  has_attached_file :cover_image_small_a, styles: { medium: '150x150#', thumb: '100x100#' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover_image_small_a, content_type: /\Aimage\/.*\Z/

  has_attached_file :cover_image_small_b, styles: { medium: '150x150#', thumb: '100x100#' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover_image_small_b, content_type: /\Aimage\/.*\Z/

  has_attached_file :cover_image_small_c, styles: { medium: '150x150#', thumb: '100x100#' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover_image_small_c, content_type: /\Aimage\/.*\Z/

  has_attached_file :cover_image_small_d, styles: { medium: '150x150#', thumb: '100x100#' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover_image_small_d, content_type: /\Aimage\/.*\Z/

  has_attached_file :wechat_share_icon, styles: { medium: '150x150#', thumb: '100x100#' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :wechat_share_icon, content_type: /\Aimage\/.*\Z/  

  has_many :routes, dependent: :destroy
  has_many :departures, through: :routes
  has_many :high_lights, dependent: :destroy
  has_many :slides, dependent: :destroy
  has_and_belongs_to_many :tour_categories

  def start_price
    departure = self.departures.order(:price).first
    if departure.nil? || departure.price.nil?
      0
    else
      departure.price
    end
  end
end
