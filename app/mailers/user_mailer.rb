class UserMailer < ApplicationMailer
  def user_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome !!",body: 'something')
  end

end
