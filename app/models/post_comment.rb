class PostComment < ApplicationRecord
  validates :comment, presence: true, length: { maximum: 500 }

  belongs_to :user
  belongs_to :counseling_post
  has_many :good_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  scope :created_this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_day) }

  def good_commented_by?(user)
    good_comments.exists?(user_id: user.id)
  end

  #相談者からグッドアドバイス評価がもらえたときの通知
  def create_notification_by(current_user, id, user_id)
    return if current_user.id == user_id
    notification = current_user.active_notifications.new(
      post_comment_id: id,
      visited_id: user_id,
      action: "good_comment"
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

end
