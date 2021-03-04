class Post < ApplicationRecord
  belongs_to :discussion
  belongs_to :user
  has_rich_text :body
  
  scope :sorted, ->{ order(created_at: :asc)}

  def send_notification!
    users = discussion.users.uniq - [user]
    user.each do |user|
      DiscussionMailer.new_post(self, user).deliver_later
    end
  end

end
