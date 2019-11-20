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


%W[仕事 家族 友人 個人 継続 単発].each { |a| Label.create(name: a) }
