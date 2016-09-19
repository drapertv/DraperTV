class AddSessionIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :session_id, :integer
  end
end
