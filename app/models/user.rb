class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence:true, length: { maximum: 15 }
  validates :introduction, length: { maximum: 50 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :counseling_posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :counseling_post_favoirtes, through: :favorites, source: :counseling_post
  has_many :good_comments, dependent: :destroy
  has_many :good_comments_through_post_comments, through: :post_comments, source: :good_comments
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy



  ## ユーザーのgood_commentsの数（グッドアドバイス数）を取得。
  def total_good_comments_count
    good_comments_through_post_comments.count
  end


  #ランキングで表示するトータル数を取得。
  def good_comments_count
    good_comments_through_post_comments.created_this_month.count
  end

  def post_commennts_count
    post_comments.created_this_month.count
  end

  def votes_count
    votes.created_this_month.count
  end

  def total_count
    good_comments_count +  post_commennts_count + votes_count
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/user.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-user-image.png', content_type: 'image/jpeg')
    end
    profile_image
  end


  #ゲストログイン機能としてゲストユーザーを作成する
  def self.guest
    find_or_create_by!(name: 'ゲストユーザー' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

end
