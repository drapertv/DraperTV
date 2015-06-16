class AddPopularToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :popular, :boolean
  end
end
