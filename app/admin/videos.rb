ActiveAdmin.register Video do

  permit_params :title, :author_id, :speaker, :description, :url, :value,:thumbnail, :name,:category_list, :video_id

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  index do
    column :id
    column :title
    column :description
    column :speaker
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Video Details" do
     f.inputs :title
     f.inputs :description
     f.inputs :video_id
     f.inputs :author_id
     f.inputs :category_list
     f.inputs :url
   end
  f.actions
 end



end
