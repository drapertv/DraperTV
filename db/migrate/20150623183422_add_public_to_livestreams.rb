class AddPublicToLivestreams < ActiveRecord::Migration
  def change
    add_column :livestreams, :public, :boolean, default: false
  end
end
