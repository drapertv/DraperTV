class AddImageUrlAndStreamDateToLivestreams < ActiveRecord::Migration
  def change
    add_column :livestreams, :image_url, :string
    add_column :livestreams, :stream_date, :datetime
  end
end
