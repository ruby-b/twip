json.array!(@tests) do |test|
  json.extract! test, :id, :test
  json.url test_url(test, format: :json)
end
