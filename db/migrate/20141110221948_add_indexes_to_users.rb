class AddIndexesToUsers < ActiveRecord::Migration
  def change
  	 add_column :users, :authentication_token, :string
  	 add_index :users, :confirmation_token,   :unique => true
     add_index :users, :authentication_token, :unique => true
  end
end
