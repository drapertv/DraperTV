class AddSpeakerNameToLivestreams < ActiveRecord::Migration
  def change
    add_column :livestreams, :speaker_name, :string
    add_column :livestreams, :speaker_position, :string
  end
end
