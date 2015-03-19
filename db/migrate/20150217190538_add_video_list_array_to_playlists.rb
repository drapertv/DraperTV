class AddVideoListArrayToPlaylists < ActiveRecord::Migration
  def change
	  add_column :playlists, :video_ids, :integer, :array => true
  end
end
