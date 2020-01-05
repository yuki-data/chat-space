if @status == "success"
  json.status @status
  json.message_id @new_message.id
  json.user_name @new_message.user.name
  json.updated_at @new_message.updated_at.strftime("%Y/%m/%d(%a) %H:%M")
  json.content @new_message.content
  json.image_url @new_message.image_url
  json.image_alt @new_message.image.identifier
else
  json.status @status
  json.error_message @error_message
end
