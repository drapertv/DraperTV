class AddWistiaIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :wistia_id, :string
  end
end
