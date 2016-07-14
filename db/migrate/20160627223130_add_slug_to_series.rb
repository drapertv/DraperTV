class AddSlugToSeries < ActiveRecord::Migration
  def change
    add_column :series, :slug, :string, unique: true
    add_index :series, :slug
  end
end
