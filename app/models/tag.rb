class Tag < ApplicationRecord

  has_many :post_tags,dependent: :destroy, foreign_key: 'tag_id'
  has_many :counseling_posts,through: :post_tags

end
