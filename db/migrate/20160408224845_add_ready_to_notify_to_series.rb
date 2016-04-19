class AddReadyToNotifyToSeries < ActiveRecord::Migration
  def change
    add_column :series, :ready_to_notify, :boolean, default: false
  end
end
