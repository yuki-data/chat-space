json.array! @messages do |message|
  json.message_id message.id
  json.user_name message.user.name
  json.updated_at message.updated_at.strftime("%Y/%m/%d(%a) %H:%M")
  json.content message.content
  json.image_url message.image_url
  json.image_alt message.image.identifier
end
