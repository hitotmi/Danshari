class Vote < ApplicationRecord

  validates :option, presence:true

  belongs_to :user
  belongs_to :counseling_post

  enum option: { discard: '捨てる', keep: '捨てない', either: 'どちらでもよい' }

  scope :created_this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_day) }

end
