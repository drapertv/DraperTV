class AddLexicaIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :lexica_id, :string
    add_column :livestreams, :lexica_id, :string
  end
end
