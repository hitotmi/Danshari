class RenameCounselingPostInPostTags < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_tags, :counseling_post, :counseling_post_id
  end
end
