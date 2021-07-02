# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
100.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
               
50.times do |n|
  user_id = 1
  work  = Faker::Job.field
  detail = Faker::Job.title
  Task.create!(user_id: 1,
               work: work,
               detail: detail)
end
               
50.times do |n|
  user_id = 2
  work  = Faker::Job.field
  detail = Faker::Job.title
  Task.create!(user_id: 2,
               work: work,
               detail: detail)
end
               
50.times do |n|
  user_id = 3
  work  = Faker::Job.field
  detail = Faker::Job.title
  Task.create!(user_id: 3,
               work: work,
               detail: detail)
end