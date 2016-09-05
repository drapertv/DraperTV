class AddOrderToSeriesAndLivestreams < ActiveRecord::Migration
  def change
  	add_column :series, :order, :integer
  	add_column :livestreams, :order, :integer
  end
end
