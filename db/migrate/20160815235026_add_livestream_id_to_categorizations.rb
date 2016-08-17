class AddLivestreamIdToCategorizations < ActiveRecord::Migration
  def change
    add_column :categorizations, :livestream_id, :integer
  end
end
