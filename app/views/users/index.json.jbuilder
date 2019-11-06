json.array! @users do |user|
  json.user_id user.id
  json.user_name user.name
end
