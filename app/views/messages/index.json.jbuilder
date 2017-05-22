json.array!(@reload_messages) do |reload_message|
  json.id reload_message.id
  json.body reload_message.body
  json.url reload_message.image.url
  json.created_at reload_message.created_at.strftime('%Y-%m-%d %H:%M:%S')
  json.name reload_message.user.name
end
