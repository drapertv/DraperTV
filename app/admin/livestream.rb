ActiveAdmin.register Livestream do
  menu priority: 4
  permit_params :title, :description, :src_url, :image_url, :stream_date, :slug, :popular, :vthumbnail, :public, :ready_to_notify, :speaker_name, :speaker_position
  filter :speaker_name
  filter :stream_date
  filter :slug
  filter :by_categorization_in, label: "Categorization", as: :select, collection: Category.all.pluck(:name)

  index do
    selectable_column
    column :id
    column :speaker_name
    column :speaker_position
    column :admin_stream_date
    column :category
    column :slug
    column :marketing_slug
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Livestream Details" do
     f.inputs :vthumbnail
     f.inputs do
        f.input :category, :label => 'Categories', :as => :select, :collection => Category.all.map{|c| c.name }
      end
     f.inputs :speaker_name
     f.inputs :speaker_position
     f.inputs :stream_date
     f.inputs :description
     f.inputs :slug
     f.inputs :marketing_slug
     f.inputs :src_url
     f.inputs :ready_to_notify
   end
  f.actions
 end

 controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end

    def create
      livestream = Livestream.create livestream_params
      category_name = params[:livestream][:category]
      category = Category.find_by_name category_name
      Categorization.create livestream_id: livestream.id, category_id: category.id if category
      redirect_to admin_livestreams_path
    end

    def update
      livestream = Livestream.find_by_slug params[:id]
      category_name = params[:livestream][:category]
      category = Category.find_by_name category_name
      Categorization.find_by_livestream_id(livestream.id).destroy if Categorization.find_by_livestream_id(livestream.id)
      Categorization.create livestream_id: livestream.id, category_id: category.id if category

      livestream.update_attributes livestream_params

      redirect_to admin_livestreams_path
    end

    def livestream_params
      params.require(:livestream).permit(:marketing_slug, :title, :description, :src_url, :image_url, :stream_date, :slug, :popular, :vthumbnail, :public, :ready_to_notify, :speaker_name, :speaker_position)
    end
  end



end