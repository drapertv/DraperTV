class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer :chapter_uid
      t.integer :number
      t.string :topic_name
      t.text :description
      t.text :lessons_info
      t.integer :topic_uid
    end
  end
end
