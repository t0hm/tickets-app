# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

students = [
    ["Thomas", "Colombet", 1],
    ["Anthony", "Corgier", 1],
    ["Sami", "Guera", 0],
    ["Alexia", "Benigno", 0],
    ["Florian", "Dumas", 0],
    ["Amélia", "Callamard", 0],
    ["Raphaël", "Daul", 0],
    ["Emre", "Kocak", 0],
    ["Sarah", "Aidoudi", 0],
    ["Alexis", "Joubert", 0],
    ["Leo", "Muller", 0],
    ["Dimitri", "Louche", 0],
    ["Fahami", "Mohamed Ali", 0],
    ["Medhi", "Alane", 0],
    ["Hamza", "Benkejjane", 0],
    ["Steven", "Bui", 0],
    ["Nadir", "Chaïeb", 0],
    ["Hadjer", "Abdelli", 0],
    ["Kadidiatou", "Keita", 0],
    ["Christophe", "Lapierre", 0],
    ["Sophiane", "Slimani", 0],
    ["Olivier", "Ferrier", 0],
]

Classroom.create(city: 0)
Classroom.create(city: 1)
Classroom.create(city: 2)
Classroom.create(city: 3)
puts "Classrooms créés"

students.each_with_index do |student, i|
    User.create(email: "#{students[i][0]}@demo.com", password: "123456", prenom: students[i][0], nom: students[i][1], classroom_id: Classroom.first.id, status: students[i][2])
    puts "#{students[i][0]} #{students[i][1]} créé."
end