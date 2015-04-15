class AddVideoUrlToComments < ActiveRecord::Migration
  def change
    add_column :comments, :video_url, :string
  end
end
