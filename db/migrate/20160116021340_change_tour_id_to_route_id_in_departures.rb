class ChangeTourIdToRouteIdInDepartures < ActiveRecord::Migration
  def change
    rename_column :departures, :tour_id, :route_id
  end
end
