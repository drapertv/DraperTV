class ChangeDescriptionInLivestream < ActiveRecord::Migration
  def change
  	change_column :livestreams, :description, :text
  end
end
