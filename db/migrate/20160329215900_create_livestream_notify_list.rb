class CreateLivestreamNotifyList < ActiveRecord::Migration
  def change
    create_table :livestream_notify_lists do |t|
      t.integer :users, array: true
    end
  end
end
