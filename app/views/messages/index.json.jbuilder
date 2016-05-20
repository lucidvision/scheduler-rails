json.array! @messages.reverse do |message|
  json.id message.id
  json.body message.body
  json.read message.read
  json.date record.created_at.strftime("%a, %b %d")
  json.time record.created_at.strftime("%I:%M %p")
end
