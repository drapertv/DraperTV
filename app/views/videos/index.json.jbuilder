json.array!(@videos) do |video|
  json.extract! video, :id, :title, :author_id, :speaker, :description, :url, :value
  json.url video_url(video, format: :json)
end
