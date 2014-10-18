# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |x|
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, encrypted_password: 'picka dinamo')
end

100.times do |x|
  Post.create!(author_id: (1..100).to_a.sample, title: Faker::Name.title, body: Faker::Lorem.sentence(12, true, 4))
end

