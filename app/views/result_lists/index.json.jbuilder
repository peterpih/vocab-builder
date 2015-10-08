json.array!(@result_lists) do |result_list|
  json.extract! result_list, :id, :sessionid, :type, :value, :order
  json.url result_list_url(result_list, format: :json)
end
