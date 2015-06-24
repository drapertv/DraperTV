class AddPublicToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :public, :boolean, default: false
  end
end
