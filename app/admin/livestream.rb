ActiveAdmin.register Livestream do

  permit_params :title, :description, :src_url, :image_url, :stream_date, :slug

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
     f.inputs :image_url
     f.inputs :stream_date
     f.inputs :slug
   end
  f.actions
 end

 controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end



end