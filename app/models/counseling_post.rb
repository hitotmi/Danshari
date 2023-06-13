class CounselingPost < ApplicationRecord

  validates :title, presence:true, length: { maximum: 50 }, presence:true
  validates :content, length: { maximum: 500 }, presence:true
  validates :status, presence:true

  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags
  has_many :notifications, dependent: :destroy



  enum status: { answer_reception: "回答受付中", resolved: "解決済" }
  enum usage_frequency: { everyday: "毎日", weeks_once: "週に1回", month_once: "月に1回", once_to_half_year: "半年に1回", once_to_1_year: "1年に1回", unused: "ほとんど使っていない" }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def voted_by?(user)
    votes.exists?(user_id: user.id)
  end


  # コメントの通知
  def create_notification_post_comment!(current_user, post_comment_id)
    # コメントをしたユーザー（current_user）がコメントの所有者（user_id）でない場合、通知を保存する
    if user_id != current_user.id
      save_notification_post_comment!(current_user, post_comment_id, user_id)
    end
  end

  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    # 通知オブジェクトを作成
    notification = current_user.active_notifications.new(
      counseling_post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    # 通知オブジェクトが有効な場合のみ保存する
    notification.save if notification.valid?
  end

  #参考になった（いいね）の通知
  def create_notification_by(current_user, id, user_id)
    return if current_user.id == user_id
    notification = current_user.active_notifications.new(
      counseling_post_id: id,
      visited_id: user_id,
      action: "favorite"
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end


  def self.search_for(content)
    if content.present?
       CounselingPost.where('title LIKE :search OR content LIKE :search', search: "%#{content}%")
    else
      CounselingPost.all
    end
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
