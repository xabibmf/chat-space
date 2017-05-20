json.messages do
  json.id @message.id
  json.body @message.body
  json.image @message.image
  json.created_at @message.created_at.strftime('%Y-%m-%d %H:%M:%S')
  json.user do
    json.name @message.user.name
  end
end
