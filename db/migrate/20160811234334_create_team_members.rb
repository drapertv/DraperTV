class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :email
      t.string :position
      t.string :linkedin
      t.boolean :current
    end
  end
end
