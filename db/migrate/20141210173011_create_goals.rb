class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :user_id, null: false
      t.boolean :completed, null: false, default: false
      t.string :privacy, null: false, default: "Private"
      t.timestamps
    end

    add_index :goals, :user_id
    add_index :goals, [:user_id, :title], unique: true
  end
end
