class AddViewCountToChallenges < ActiveRecord::Migration
  def change
    change_column :challenges, :view_count, :integer, default: 0
  end
end
