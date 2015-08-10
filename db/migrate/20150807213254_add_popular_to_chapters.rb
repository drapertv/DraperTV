class AddPopularToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :popular, :boolean
    add_column :chapters, :name, :string
  end
end
