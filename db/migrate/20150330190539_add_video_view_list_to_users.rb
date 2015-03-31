class AddVideoViewListToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :video_view_list, :integer, :array => true
  end
end
