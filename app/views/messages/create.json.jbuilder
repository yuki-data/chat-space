json.user_name @new_message.user.name
json.updated_at @new_message.updated_at.strftime("%Y/%m/%d(%a) %H:%M")
json.content @new_message.content
json.image_url @new_message.image_url
json.image_alt @new_message.image.identifier
