class UserMailer < ApplicationMailer
  def approve_post(user_id)
    @user = User.find(user_id)

    mail(   :to      => @user.email,
            :subject => "approve post"
    ) do |format|
      format.html
    end
  end
end