class AddPublicToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :public, :boolean, default: true
  end
end
