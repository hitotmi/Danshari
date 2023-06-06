class PostTag < ApplicationRecord
  belongs_to :counseling_post
  belongs_to :tag
end
