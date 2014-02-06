json.array!(@client_phones) do |client_phone|
  json.extract! client_phone, :id, :phone, :client_id
  json.url client_phone_url(client_phone, format: :json)
end
