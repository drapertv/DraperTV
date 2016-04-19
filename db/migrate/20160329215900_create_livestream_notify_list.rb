class CreateLivestreamNotifyList < ActiveRecord::Migration
  def change
    create_table :livestream_notify_lists do |t|
      t.integer :emails, array: true
    end
  end
end
