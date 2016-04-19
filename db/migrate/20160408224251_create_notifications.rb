class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :email_id
      t.integer :livestream_id
    end
  end
end
