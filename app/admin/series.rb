ActiveAdmin.register Series do


  permit_params :title, :price, :video_ids,:author_id, :video_ids_raw, :popular, :category_list, :show_on_front_page, :public

  index do
    column :id
    column :title
    column :price
    column :video_ids
    column :author_id
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Series Details" do
    f.inputs :title
    f.inputs :price
    f.inputs :author_id
    f.inputs :category_list
    f.inputs :video_ids_raw, :as => :text
    f.inputs :popular
    f.inputs :show_on_front_page
    f.inputs :public
   end
  f.actions
 end


end
