class AddSpeakerTitle < ActiveRecord::Migration
  def change
  	add_column :speakers, :title, :string
  end
end
