class UserMailer < ApplicationMailer
  def user_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome !!",body: 'something')
  end

end
