class FollowedMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.followed_mailer.followed_mail.subject
  #
  def followed_mail
    @user = params[:user]
    @following_user = params[:following_user]
    mail to: @user.email, subject: "#{@following_user.name} followed you!"
  end
end
