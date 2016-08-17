class AddSpeakerNameToSeries < ActiveRecord::Migration
  def change
    add_column :series, :speaker_name, :string
    add_column :series, :speaker_position, :string
    add_column :series, :vthumbnail, :string
  end
end
