class AddPublicToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :public, :boolean, default: false
  end
end
