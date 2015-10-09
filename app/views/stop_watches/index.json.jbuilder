json.array!(@stop_watches) do |stop_watch|
  json.extract! stop_watch, :id, :start, :stop
  json.url stop_watch_url(stop_watch, format: :json)
end
