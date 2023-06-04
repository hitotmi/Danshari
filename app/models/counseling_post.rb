class CounselingPost < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence:true
  validates :content, length: { maximum: 200 }, presence:true
  validates :status, presence:true

  enum status: { answer_reception: "回答受付中", resolved: "解決済" }
  enum usage_frequency: { everyday: "毎日", weeks_once: "週に1回", month_once: "月に1回", once_to_half_year: "半年に1回", once_to_1_year: "1年に1回", unused: "ほとんど使っていない" }

    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
    end


  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
