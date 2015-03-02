class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :title
      t.integer :video_id
      t.integer :price
      t.integer :challange_id

      t.timestamps
    end
  end
end
