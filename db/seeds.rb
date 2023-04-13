# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Classroom.create(city: 0)
Classroom.create(city: 1)
Classroom.create(city: 2)
Classroom.create(city: 3)

puts "Classrooms créés"
User.create(email: "thomas@demo.com", password: "123456", prenom: "Thomas", nom: "Colombet", classroom_id: Classroom.first.id, status: 1)
puts "Utilisateur Thomas créé"
User.create(email: "christophe@demo.com", password: "123456", prenom: "Christophe", nom: "Lapierre", classroom_id: Classroom.first.id, status: 0)
puts "Utilisateur Christophe créé"
User.create(email: "raphael@demo.com", password: "123456", prenom: "Raphaël", nom: "Daul", classroom_id: Classroom.first.id, status: 0)
puts "Utilisateur Raphaël créé"