json.array!(@days) do |day|
  json.extract! day, :id, :number, :modal_title, :modal_content, :previous_day_id, :next_day_id
  json.url day_url(day, format: :json)
end
