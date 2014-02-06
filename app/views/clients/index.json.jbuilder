json.array!(@clients) do |client|
  json.extract! client, :id, :cod, :name, :last_name, :address, :job_address, :obs
  json.url client_url(client, format: :json)
end
