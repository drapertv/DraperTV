class AddProfilepicToTeamMembers < ActiveRecord::Migration
  def change
    add_column :team_members, :profilepic, :string
  end
end
