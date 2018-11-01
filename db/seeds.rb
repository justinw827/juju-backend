# UserGroup.destroy_all
# User.destroy_all
# Event.destroy_all
# Group.destroy_all

puts "Creating users"
u = User.create!(spotify_id: "1234", access_token: "", refresh_token: "")
puts "Done creating users"

puts "Creating groups"
g = Group.create!(name: "Cool Group")
puts "Done creating users"

puts "Creating user groups"
UserGroup.create!(user_id: u.id, group_id: g.id)
puts "Done creating user groups"

puts "Creating events"
Event.create!(group_id: g.id, playlist_id: "3qBswSHe4Hhjux8tpB4qGE", name: "Cool Event", description: "This is a cool event")
puts "Done creating events"
