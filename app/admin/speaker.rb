ActiveAdmin.register Speaker do
permit_params :name, :email, :profilepic, :bio

index do
    column :id
    column :name
    column :email
    column :bio
    column :profilepic
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "User Details" do
     f.inputs :name
     f.inputs :email
     f.inputs :profilepic
     f.inputs :bio
   end
  f.actions
 end



end
