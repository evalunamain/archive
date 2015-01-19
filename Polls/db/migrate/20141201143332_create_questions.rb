class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :body
      t.integer :poll_id

      t.timestamps
    end

    add_index :questions, :poll_id
  end
end
