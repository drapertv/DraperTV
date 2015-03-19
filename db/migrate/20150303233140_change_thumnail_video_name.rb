class ChangeThumnailVideoName < ActiveRecord::Migration
  def change
  	rename_column :videos, :thumbnail, :vthumbnail
  end
end
