ActiveAdmin.register Video do
  menu false
  permit_params :wistia_id, :video_type, :title, :author_id, :speaker, :description, :url, :value,:vthumbnail, :name, :video_id, :length, :slug, :public

  index do
    column :id
    column :title
    column :description
    column :author_id
    column :url
    column :video_type

    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Video Details" do
     f.inputs :title
     f.inputs :url
     f.inputs :author_id
     f.inputs :value
     f.inputs :video_id
     f.inputs :vthumbnail
     f.inputs :description
     f.inputs :length
     f.inputs :wistia_id
     f.inputs :video_type
     f.inputs :slug
     f.inputs :public
   end
  f.actions
 end


  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end



end
