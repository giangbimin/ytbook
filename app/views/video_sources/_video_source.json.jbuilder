json.extract! video_source, :id, :provider, :identify_id, :created_at, :updated_at
json.url video_source_url(video_source, format: :json)
