json.array!(@use_cases) do |use_case|
  json.extract! use_case, :id, :title, :preconditions, :steps, :postconditions, :requirements, :requirements, :priority, :identifier
  json.url use_case_url(use_case, format: :json)
end
