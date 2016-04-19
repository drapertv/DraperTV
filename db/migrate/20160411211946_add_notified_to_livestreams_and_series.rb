class AddNotifiedToLivestreamsAndSeries < ActiveRecord::Migration
  def change
    add_column :series, :notified, :boolean, default: false
    add_column :livestreams, :notified, :boolean, default: false
  end
end
