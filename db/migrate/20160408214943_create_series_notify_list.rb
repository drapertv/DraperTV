class CreateSeriesNotifyList < ActiveRecord::Migration
  def change
    create_table :series_notify_lists do |t|
      t.integer :emails, array: true
    end
  end
end
