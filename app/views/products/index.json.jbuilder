json.array!(@products) do |product|
  json.extract! product, :id, :name, :cod, :description, :surcharge, :category_id, :iva_id
  json.url product_url(product, format: :json)
end
