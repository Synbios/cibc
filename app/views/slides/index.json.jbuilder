json.array!(@slides) do |slide|
  json.extract! slide, :id, :name, :tour_id
  json.url slide_url(slide, format: :json)
end
