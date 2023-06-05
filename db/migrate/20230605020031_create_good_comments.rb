class CreateGoodComments < ActiveRecord::Migration[6.1]
  def change
    create_table :good_comments do |t|
      t.integer :user_id,         null: false
      t.integer :post_comment_id, null: false

      t.timestamps
    end
  end
end
