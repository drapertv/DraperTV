ActiveAdmin.register User do

  permit_params :name, :email, :password, :password_confirmation,:avatar,:remember_me,:bio

  index do
    column :id
    column :name
    column :email
    column :bio
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "User Details" do
     f.inputs :name
     f.inputs :email
     f.inputs :password
     f.inputs :password_confirmation
     f.inputs :avatar
     f.inputs :bio
   end
  f.actions
 end



end
