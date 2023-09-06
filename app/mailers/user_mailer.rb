class UserMailer < ApplicationMailer
  layout 'mailer'
  
  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome !!")
  end

end
