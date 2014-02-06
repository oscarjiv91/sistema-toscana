json.array!(@product_data) do |product_datum|
  json.extract! product_datum, :id, :quantity, :price, :product_id
  json.url product_datum_url(product_datum, format: :json)
end
