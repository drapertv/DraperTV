class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.integer :playlist_id
      t.text :description
      t.string :title
      t.integer :view_count
      t.string :url
      t.string :vthumbnail

      t.timestamps
    end
  end
end
