class AddAuthorToPlaylist < ActiveRecord::Migration
  def change
  	add_column :playlists, :author_id, :integer
  end
end
