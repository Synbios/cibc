class TourAvator < Tour

  has_attached_file :content_image, :styles => { :minified => {:format => "jpg"} }, :processors => [:minify], default_url: "/images/:style/missing.png"
  validates_attachment_content_type :content_image, content_type: /\Aimage\/.*\Z/
  
  has_many :shards, dependent: :destroy

  def slice_content_image
    original_path = self.content_image.path(:minified)
    if original_path.present?
      # remove all shards
      self.shards.delete_all

      # slice original image into smaller images
      system("convert #{original_path}  -crop 800x600  tmp/ta_#{self.id}_%d.jpg")

      # turn slice images into shards
      file_paths = `ls tmp/ta_#{self.id}_*.jpg`.split("\n")
      file_paths.each do |file_path|
        shard = self.shards.new
        shard.order = /(\d+)\.jpg/.match(file_path).captures.first
        file = File.open(file_path)
        shard.image = file
        file.close
        shard.save!
      end

      # remove tmp files
      system("rm tmp/ta_#{self.id}_*.jpg")
    end
  end
end
