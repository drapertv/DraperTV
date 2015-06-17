class AddVthumbnailToLivestreams < ActiveRecord::Migration
  def change
    add_column :livestreams, :vthumbnail, :string
  end
end
