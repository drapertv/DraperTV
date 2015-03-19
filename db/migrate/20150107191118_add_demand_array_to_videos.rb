class AddDemandArrayToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :demand_array, :integer, :array => true
  end
end
