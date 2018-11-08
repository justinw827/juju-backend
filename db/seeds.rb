# UserGroup.destroy_all
# User.destroy_all
# Event.destroy_all
# Group.destroy_all

puts "Creating users"
for i in 0..9
  new_id = "100" + i.to_s
  User.create!(spotify_id: new_id, access_token: "", refresh_token: "", external_url: "", image_url: "")
end
puts "Done creating users"

puts "Creating groups"
g = Group.create!(name: "Cool Group")
puts "Done creating users"

puts "Creating user groups"
UserGroup.create!(user_id: User.all.sample.id, group_id: g.id)
puts "Done creating user groups"

puts "Creating events"
Event.create!(group_id: g.id, host_id: User.all.sample.id, playlist_id: "3qBswSHe4Hhjux8tpB4qGE", name: "Cool Event", description: "This is a cool event")
Event.create!(group_id: g.id, host_id: User.all.sample.id, playlist_id: "3qBswSHe4Hhjux8tpB4qGE", name: "Cool Event 2", description: "This is a cool event 2")
Event.create!(group_id: g.id, host_id: User.all.sample.id, playlist_id: "3qBswSHe4Hhjux8tpB4qGE", name: "Cool Event 3", description: "This is a cool event 3")
Event.create!(group_id: g.id, host_id: User.all.sample.id, playlist_id: "3qBswSHe4Hhjux8tpB4qGE", name: "Cool Event 4", description: "This is a cool event 4")
puts "Done creating events"

puts "Creating user events"
UserEvent.create!(user_id: User.all.sample.id, event_id: Event.all.sample.id)
UserEvent.create!(user_id: User.all.sample.id, event_id: Event.all.sample.id)
UserEvent.create!(user_id: User.all.sample.id, event_id: Event.all.sample.id)
puts "Done creating user events"
