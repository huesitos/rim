json.array!(@requirements) do |requirement|
  json.extract! requirement, :id, :title, :description, :identifier, :priority
  json.url requirement_url(requirement, format: :json)
end
