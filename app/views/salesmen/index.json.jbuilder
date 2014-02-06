json.array!(@salesmen) do |salesman|
  json.extract! salesman, :id, :name, :phone, :supplier_id
  json.url salesman_url(salesman, format: :json)
end
