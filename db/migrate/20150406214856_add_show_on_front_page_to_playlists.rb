class AddShowOnFrontPageToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :show_on_front_page, :boolean
  end
end
