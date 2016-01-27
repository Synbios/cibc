class Departure < ActiveRecord::Base
  belongs_to :route

  def calender_message
    if self.seats.present? && self.seats > 0
      self.price
    else
      "已满"
    end
  end
end
