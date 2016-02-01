module Paperclip
  class Minify < Processor  
    attr_accessor :format, :whiny, :label
    
    def initialize file, options = {}, attachment = nil
      @file             = file
      @whiny            = options[:whiny].nil? ? true : options[:whiny]
      @format           = options[:format]
      @label            = options[:label]
      
      @current_format   = File.extname(@file.path)
      @basename         = File.basename(@file.path, @current_format)
     end
 
    # Performs the conversion of the +file+ into a watermark. Returns the Tempfile
    # that contains the new image.
    def make

      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode
      
      command = "convert"
      params = "-strip -interlace Plane -gaussian-blur 0.05 -quality 85% #{fromfile} - | convert - -resize '800x1000000>' #{@format}:#{tofile(dst)}"
      
      begin
        success = Paperclip.run(command, params)
      rescue
        puts "There was an error processing #{@basename}"
      end
 
      dst
    end
 
    def fromfile
      "\"#{ File.expand_path(@file.path) }\""
    end
 
    def tofile(destination)
      "\"#{ File.expand_path(destination.path) }\""
    end    
  end
  # create mask
  # convert -size 267x159 pattern:crosshatch45 -auto-level +level-colors grey90,white -transparent white mask1.png
  # create card
  # convert free.jpg -resize 267x159^ -gravity center -extent 267x159 - | convert - logo.png -geometry +10+25 -composite s2.jpg
end