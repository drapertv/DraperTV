class AddLengthToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :length, :string
  end
end
