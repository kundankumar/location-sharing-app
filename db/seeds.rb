# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create({ name: 'Kundan', username: 'kundan', email: 'kundan@example.com', password: 'Test@123'})
p1 = Place.new({ name: 'Bangalore' })
p1.user = u1
p1.save

l1 = Location.new({ lat: 12.9538477, lng: 77.3507442 })
l1.place = p1
p1.save

u2 = User.create({ name: 'Kumar', username: 'kumar', email: 'kumar@example.com', password: 'Test@123'})
p2 = Place.new({ name: 'Kolkata' })
p2.user = u2
p2.save

l2 = Location.create({ lat: 22.6060082, lng: 88.3706760 })
l2.place = p2
p2.save
