json.array!(@ivas) do |iva|
  json.extract! iva, :id, :iva
  json.url iva_url(iva, format: :json)
end
