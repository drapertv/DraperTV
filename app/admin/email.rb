ActiveAdmin.register Email do
  menu priority: 5
  filter :body

  index do
    selectable_column
    column :id
    column :body
    actions
  end


end