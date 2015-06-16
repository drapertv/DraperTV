class AddPopularToLivestreams < ActiveRecord::Migration
  def change
    add_column :livestreams, :popular, :boolean
  end
end
