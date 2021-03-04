# Preview all emails at http://localhost:3000/rails/mailers/discussion_mailer
class DiscussionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/discussion_mailer/new_post
  def new_post
    DiscussionMailer.new_post
  end

end
