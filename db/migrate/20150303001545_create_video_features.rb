class CreateVideoFeatures < ActiveRecord::Migration
  def change
    create_table :video_features do |t|
      t.integer :video_id
      t.boolean :type_qwatch, :default => false
      t.boolean :type_series, :default => false

      t.timestamps
    end
  end
end
