json.array!(@video_features) do |video_feature|
  json.extract! video_feature, :id, :video_id, :type_qwatch, :type_series
  json.url video_feature_url(video_feature, format: :json)
end
