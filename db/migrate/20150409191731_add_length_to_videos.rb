class AddLengthToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :length, :string
  end
end
