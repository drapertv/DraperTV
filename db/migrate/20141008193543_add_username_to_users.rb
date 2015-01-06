class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    change_column_null :users, :email, true
  end
end
