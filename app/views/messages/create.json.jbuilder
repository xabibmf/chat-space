json.id @message.id
json.body @message.body
json.url @message.image.url
json.created_at @message.created_at.strftime('%Y-%m-%d %H:%M:%S')
json.name @message.user.name
