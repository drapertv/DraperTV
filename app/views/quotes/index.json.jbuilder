json.array!(@quotes) do |quote|
  json.extract! quote, :id, :author_id, :speaker_id, :content, :shared, :sharedCounter
  json.url quote_url(quote, format: :json)
end
