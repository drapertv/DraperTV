class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
    	t.string :name
    end
  end
end
