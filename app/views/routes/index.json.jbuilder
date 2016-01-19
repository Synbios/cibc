json.array!(@routes) do |route|
  json.extract! route, :id, :tour_id, :name
  json.url route_url(route, format: :json)
end
