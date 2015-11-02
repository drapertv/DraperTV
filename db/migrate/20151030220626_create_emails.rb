class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :body
      t.datetime :created_at

      t.timestamps
    end
  end
end
