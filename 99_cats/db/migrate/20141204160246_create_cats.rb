class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date
      t.string :color, presence: true
      t.string :name, presence: true
      t.string :sex, presence: true
      t.text :description

      t.timestamps
    end
  end
end
