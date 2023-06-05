class PostComment < ApplicationRecord
  validates :comment, presence:true

  belongs_to :user
  belongs_to :counseling_post
  has_many :good_comments, dependent: :destroy

  def good_commented_by?(user)
    good_comments.exists?(user_id: user.id)
  end

end
