json.projects @projects do |project|
  json.id project.id
  json.title project.title
  json.director project.director
  json.phone project.phone
  json.roles project.roles
  json.auditions project.auditions
end
