class AddUnsubscribeKeyToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :unsubscribe_key, :string
  end
end
