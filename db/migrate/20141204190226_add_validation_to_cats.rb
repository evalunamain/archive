class AddValidationToCats < ActiveRecord::Migration
  def change
    change_column_null :cats, :name, false
    change_column_null :cats, :color, false
    change_column_null :cats, :sex, false
        
  end
end
