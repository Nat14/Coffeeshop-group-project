json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :address, :time, :subject, :confirm, :useridtext
  json.url meeting_url(meeting, format: :json)
end
