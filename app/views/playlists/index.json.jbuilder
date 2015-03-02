json.array!(@playlists) do |playlist|
  json.extract! playlist, :id, :title, :video_id, :price, :challange_id
  json.url playlist_url(playlist, format: :json)
end
