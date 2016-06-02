json.array! @messages.reverse do |message|
  json.id message.id
  json.sender User.find(message.user_id).name
  json.body message.body
  json.read message.read
  json.date message.created_at.localtime.strftime("%a, %b %d")
  json.time message.created_at.localtime.strftime("%I:%M %p")
end
