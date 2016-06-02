json.array! @history.reverse do |record|
  json.id record.id
  json.action record.action
  json.date record.created_at.localtime.strftime("%a, %b %d")
  json.time record.created_at.localtime.strftime("%I:%M %p")
end
