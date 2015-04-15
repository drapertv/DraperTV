class AddUrlTypeAndUrlThumbnailToComments < ActiveRecord::Migration
  def change
    add_column :comments, :url_type, :string
    add_column :comments, :url_thumbnail, :string
  end
end
