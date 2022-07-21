require "faker"

User.create([{email: "chubinidze46@gmail.com", password: "123456", password_confirmation: "123456"}])
User.first.add_role(:admin)
User.first.add_role(:vip)

100.times do 
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

