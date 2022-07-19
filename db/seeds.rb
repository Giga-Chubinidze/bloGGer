# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"
10.times do 
  user_email = Faker::Internet.email
  user_password = Faker::Number.number(digits: 6)
  User.create([{email: user_email, password: user_password, password_confirmation: user_password}])
  
  post_title = Faker::JapaneseMedia::OnePiece.character
  post_body = Faker::JapaneseMedia::OnePiece.quote
  Post.create([{title: post_title, body: post_body, user: User.last}])
  
  comment_post_id = Post.last.id
  comment_user_id = User.last.id
  comment_body = Faker::JapaneseMedia::OnePiece.akuma_no_mi
  Comment.create([{post_id: comment_post_id, user_id: comment_user_id, body: comment_body}])
end