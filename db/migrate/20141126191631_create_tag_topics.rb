class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic_name
      t.timestamps
    end

    add_index :tag_topics, :topic_name
  end
end
