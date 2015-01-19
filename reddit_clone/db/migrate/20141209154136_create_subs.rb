class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :moderator_id

      t.timestamps
    end

    add_index :subs, [:title, :moderator_id], unique: true
    add_index :subs, :moderator_id
  end
end
