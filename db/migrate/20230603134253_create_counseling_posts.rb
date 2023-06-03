class CreateCounselingPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :counseling_posts do |t|
      t.integer :user_id,         null: false
      t.string :title,            null: false
      t.text :content,            null: false
      t.string :status,           null: false
      t.string :usage_frequency
      t.integer :star
      t.timestamps
    end
  end
end
