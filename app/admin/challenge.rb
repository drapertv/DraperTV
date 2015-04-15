ActiveAdmin.register Challenge do

  permit_params :title, :description, :url, :length, :playlist_id

  index do
    column :id
    column :title
    column :description
    column :playlist_id
    column :url
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Challenge Details" do
     f.inputs :title
     f.inputs :url
     f.inputs :playlist_id
     f.inputs :description
     f.inputs :length
   end
  f.actions
 end



end
