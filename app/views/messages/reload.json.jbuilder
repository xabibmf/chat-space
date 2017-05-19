json.messages do
  json.array!(@reload_message) do |reload_message|
    json.id(reload_message.id)
    json.body(reload_message.body)
    json.image(reload_message.image)
    json.created_at(reload_message.created_at)
    json.user do
      json.name(reload_message.user.name)
    end
  end
end
