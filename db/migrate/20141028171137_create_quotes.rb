class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :author_id
      t.integer :speaker_id
      t.string :content
      t.boolean :shared, default: false
      t.integer :sharedCounter, default: 0
      t.integer :video_id

      t.timestamps
    end
  end
end
