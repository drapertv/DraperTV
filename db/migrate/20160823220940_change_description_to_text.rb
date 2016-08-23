class ChangeDescriptionToText < ActiveRecord::Migration
  def change
    change_column :videos, :description, :text
    change_column :series, :description, :text
    change_column :livestreams, :description, :text
  end
end
