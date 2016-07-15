class AddViewCountToSeries < ActiveRecord::Migration
  def change
    add_column :series, :view_count, :integer
  end
end
