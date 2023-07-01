class AddScoreAndMagnitudeToCounselingPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :counseling_posts, :score, :decimal, precision: 5, scale: 3
    add_column :counseling_posts, :magnitude, :decimal, precision: 5, scale: 3
  end
end
