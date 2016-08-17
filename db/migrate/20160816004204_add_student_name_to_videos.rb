class AddStudentNameToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :student_name, :string
  end
end
