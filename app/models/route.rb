class Route < ActiveRecord::Base
  has_many :days
  has_many :departures
  belongs_to :tour

  def reorder
    days = self.days
    for i in 0 .. days.length - 1
      if i == 0
        days[i].previous_day = nil
      else
        days[i].previous_day = days[i-1]
      end
      if i == days.length
        days[i].next_day = nil
      else
        days[i].next_day = days[i+1]
      end
      days[i].save
    end
  end

  def start_price
    departure = self.departures.order(:price).first
    if departure.nil? || departure.price.nil?
      0
    else
      departure.price
    end
  end
end
