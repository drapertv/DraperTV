class CreateLivestreams < ActiveRecord::Migration
  def change
    create_table :livestreams do |t|
      t.string :title
      t.string :description
      t.string :misc_info

      t.timestamps
    end
  end
end
