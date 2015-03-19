class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :name
      t.string :email
      t.string :profilepic
      t.string :bio

      t.timestamps
    end
  end
end
