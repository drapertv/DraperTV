ActiveAdmin.register Video, :as => 'Students' do
  menu priority: 4
  permit_params :student_name, :wistia_id, :video_type, :title, :author_id, :speaker, :description, :url, :value,:vthumbnail, :name, :video_id, :length, :slug, :public
  filter :title
  filter :student_name
  filter :slug
  filter :by_categorization_in, label: "Categorization", as: :select, collection: Category.all.pluck(:name)


  index do
    selectable_column
    column :title
    column :student_name
    column :category
    column :slug
    column :marketing_slug
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    div "Date Created: #{f.object.created_at}" 
    f.inputs :vthumbnail
    f.inputs do
      f.input :category, :label => 'Categories', :as => :select, :collection => Category.all.map{|c| c.name }
    end
    f.inputs :title
    f.inputs :student_name
    f.inputs :description
    f.inputs :slug
    f.inputs :marketing_slug
    f.inputs :wistia_id
    f.actions
  end

  controller do
    def scoped_collection
      Video.where(:video_type => "student")
    end

    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end

    def create
      video = Video.create video_params
      category_name = params[:video][:category]
      category = Category.find_by_name category_name
      Categorization.create video_id: video.id, category_id: category.id if category
      video.update_attributes video_type: "student"

      redirect_to admin_students_path

    end

    def update
      video = Video.find_by_slug params[:id]
      category_name = params[:video][:category]
      category = Category.find_by_name category_name
      Categorization.find_by_video_id(video.id).destroy if Categorization.find_by_video_id(video.id)
      Categorization.create video_id: video.id, category_id: category.id if category
      video.update_attributes video_params

      redirect_to admin_students_path
    end

    def video_params
      params.require(:video).permit(:marketing_slug, :student_name, :wistia_id, :video_type, :title, :author_id, :speaker, :description, :url, :value,:vthumbnail, :name, :video_id, :length, :slug, :public)
    end
  end
 
  # code

end