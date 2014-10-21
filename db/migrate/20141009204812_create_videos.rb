class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.integer :author_id
      t.integer :speaker
      t.text :description
      t.text :thumbnail
      t.string :url
      t.integer :value

      t.timestamps
    end
  end
end
