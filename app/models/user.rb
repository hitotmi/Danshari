class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name,presence:true
  validates :introduction, length: { maximum: 50 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :counseling_posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :counseling_post_favoirtes, through: :favorites, source: :counseling_post
  has_many :good_comments, through: :post_comments, dependent: :destroy


  #ランキングで表示するトータル数取得。
  ## ユーザーのgood_commentsの数（グッドアドバイス数）を取得。
  def total_good_comments_count
    good_comments.count
  end
  
  def post_commennts_count
    post_comments.count
  end

  def votes_count
    votes.count
  end

  def total_count
    total_good_comments_count +  post_commennts_count + votes_count
  end


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
