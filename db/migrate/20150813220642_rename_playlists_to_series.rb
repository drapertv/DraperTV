class RenamePlaylistsToSeries < ActiveRecord::Migration
  def change
    rename_table :playlists, :series
  end 
end
