class AddVideoIdToCategorizations < ActiveRecord::Migration
  def change
    add_column :categorizations, :video_id, :integer
  end
end
