class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :counseling_post
  
end
