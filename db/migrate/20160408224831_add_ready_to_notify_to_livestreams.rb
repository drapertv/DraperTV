class AddReadyToNotifyToLivestreams < ActiveRecord::Migration
  def change
    add_column :livestreams, :ready_to_notify, :boolean, default: false
  end
end
