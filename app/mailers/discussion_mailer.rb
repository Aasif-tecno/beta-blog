class DiscussionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.discussion_mailer.new_post.subject
  #
  def new_post(post, user)
    @post, @user, @discussion = post, user, post.discussion

    mail to: "#{user,name} <#{user.email}>", 
      from: "#{post.user.name} <noreply@example.com>",
      subject: "[Example App] #{@discussion.title}",
  end
end
