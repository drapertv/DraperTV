ActiveAdmin.register Livestream do

  permit_params :title, :description, :src_url

  index do
    column :title
    column :description
    column :src_url
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Livestream Details" do
     f.inputs :title
     f.inputs :description
     f.inputs :src_url
   end
  f.actions
 end



end