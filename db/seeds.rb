# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Rails.env.production?

  puts "Create admin"
  User.create!(email: "codecircle13@gmail.com", password: "mered1913", name: "הקוד השומרי", admin: true) unless User.find_by(email: "codecircle13@gmail.com").present?
  puts "Create users"
  20.times do |i|
    User.create!(email: "#{i + 1}@gmail.com", password: "123123", name: "User #{i + 1}", admin: false) unless User.find_by(email: "#{i + 1}@gmail.com").present?
    puts "Create User #{i + 1}"
  end
  5.times do |i|
    Team.create!(name: "Team #{i + 1}") unless Team.find_by(name: "Team #{i + 1}").present?
    puts "Create Team #{i + 1}"
  end

end
