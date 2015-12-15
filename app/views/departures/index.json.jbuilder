json.array!(@departures) do |departure|
  json.extract! departure, :id, :tour_id, :start_time, :seats, :price
  json.url departure_url(departure, format: :json)
end
