class ChangeIndexFromContacts < ActiveRecord::Migration
  def up
    remove_column :contacts, :index_contacts_on_user_id
    add_index :contacts, [:user_id, :email], unique: true
  end

  def down
    add_column :contacts, :index_contacts_on_user_id
  end
end
