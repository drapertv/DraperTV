class ChangeSpeakerInVideos < ActiveRecord::Migration
  def change
    change_column :videos, :speaker, :string
  end
end
