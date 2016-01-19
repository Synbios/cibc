json.array!(@high_lights) do |high_light|
  json.extract! high_light, :id, :name, :tour_id
  json.url high_light_url(high_light, format: :json)
end
