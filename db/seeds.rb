# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(
#    email: 'first@dic.com',
#    password_digest: '111111',
#    name: 'first_person',
# )

10.times do |index|
  Task.create(title: "タスク#{index}", explanation: "explanation#{index}")
end

10.times do |index|
  User.create(name: "ユーザー#{index}", email: "user#{index}@gmail.com", password: "password#{index}", password_confirmation: "password#{index}")
end

3.times do |index|
  User.create!(name: "管理者#{index}", email: "admin_user#{index}@gmail.com", password: "adminpassword#{index}", password_confirmation: "adminpassword#{index}", admin: true)
end

%W[仕事 家族 友人 個人 継続 単発].each { |a| Label.create(name: a) }
