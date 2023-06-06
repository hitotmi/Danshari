class GoodComment < ApplicationRecord

  belongs_to :user
  belongs_to :post_comment
  
  scope :created_this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_day) }
  
end
