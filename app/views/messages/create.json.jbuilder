json.messages do
  json.body(@message.body)
  json.created_at(@message.created_at)
  json.user do
    json.name(@message.user.name)
  end
end
