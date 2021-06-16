# Preview all emails at http://localhost:3000/rails/mailers/followed_mailer
class FollowedMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/followed_mailer/followed_mail
  def followed_mail
    FollowedMailer.with(user: User.first, following_user: User.second).followed_mail
  end

end
