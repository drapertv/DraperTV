json.array!(@speakers) do |speaker|
  json.extract! speaker, :id, :name, :email, :profilepic, :bio
  json.url speaker_url(speaker, format: :json)
end
