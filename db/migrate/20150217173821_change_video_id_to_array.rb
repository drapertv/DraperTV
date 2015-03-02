class ChangeVideoIdToArray < ActiveRecord::Migration
  def change
  	remove_column :playlists, :video_id
  end
end

