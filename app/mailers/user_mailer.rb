class UserMailer < ActionMailer::Base
  default from: "Invictus Graphics <noreply@invictus-hd.com>"

  #UserMailer.subscription_email("Invictus:{Post.first.id}", User.first, Post.first).deliver
  
  def subscription_email(subject,user,post)
    # Variable for view
    @user = user
    @post = post
    # Email
    email_to = "#{@user.username} <#{@user.email}>"
    email_from = "Invictus Graphics <noreply@invictus-hd.com>"
    # Create the mail
    mail(subject: subject, to: email_to, from: email_from)
  end

end