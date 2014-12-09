class RemoveSubIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :sub_id
  end
end
