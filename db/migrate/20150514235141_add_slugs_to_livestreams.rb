class AddSlugsToLivestreams < ActiveRecord::Migration
  def change
    add_column :livestreams, :slug, :string
    add_index :livestreams, :slug, unique: true
  end
end
