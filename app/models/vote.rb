class Vote < ApplicationRecord

  validates :option, presence:true

  belongs_to :user
  belongs_to :counseling_post

  enum option: { discard: '捨てる', keep: '捨てない', either: 'どちらでもよい' }

end
