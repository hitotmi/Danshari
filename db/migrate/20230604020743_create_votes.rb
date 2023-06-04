class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :user_id,            null: false
      t.integer :counseling_post_id, null: false
      t.string :option,              null: false
      t.timestamps
    end
  end
end
