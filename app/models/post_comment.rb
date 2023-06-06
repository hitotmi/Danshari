class PostComment < ApplicationRecord
  validates :comment, presence:true

  belongs_to :user
  belongs_to :counseling_post
  has_many :good_comments, dependent: :destroy

  scope :created_this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_day) }

  def good_commented_by?(user)
    good_comments.exists?(user_id: user.id)
  end

end
