class AddSummaryToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :summary, :text
  end
end
