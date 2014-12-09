class AddModeratorBooleanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :moderator_status, :boolean, default: false
  end
end
