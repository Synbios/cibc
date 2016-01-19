json.array!(@tours) do |tour|
  json.extract! tour, :id, :name, :slider_subtitle
  json.url tour_url(tour, format: :json)
end
