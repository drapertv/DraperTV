ActiveAdmin.register Playlist do


  permit_params :title, :price, :challange_id, :video_ids,:author_id, :video_ids_raw, :popular, :category_list

  index do
    column :id
    column :title
    column :price
    column :challange_id
    column :video_ids
    column :author_id
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Playlist Details" do
    f.inputs :title
    f.inputs :price
    f.inputs :challange_id
    f.inputs :author_id
    f.inputs :category_list
    f.inputs :video_ids_raw, :as => :text
    f.inputs :popular
   end
  f.actions
 end


end
