class AddFullNameToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :full_name, :string
  end
end
