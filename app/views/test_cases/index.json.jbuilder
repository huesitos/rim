json.array!(@test_cases) do |test_case|
  json.extract! test_case, :id, :identifier, :title, :steps, :preconditions, :postconditions, :use_cases, :requirements
  json.url test_case_url(test_case, format: :json)
end
