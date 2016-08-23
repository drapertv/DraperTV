ActiveAdmin.register Series, :as => 'Speakers' do
  menu priority: 3

  permit_params :title, :price, :video_ids,:author_id, :video_ids_raw, :popular, :show_on_front_page, :public, :ready_to_notify, :speaker_name, :speaker_position
  
  filter :title 
  filter :speaker_name
  filter :slug
  filter :by_categorization_in, label: "Categorization", as: :select, collection: Category.all.pluck(:name)
  filter :by_episode_title_in, label: "Episode Title", as: :text, input_html: {rows: 1}
  filter :by_episode_slug_in, label: "Episode Slug", as: :text, input_html: {rows: 1}


  index do
    selectable_column
    column :title
    column :speaker_name
    column :speaker_position
    column :category
    column :slug
    column :marketing_slug
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Series Details" do
    f.inputs :vthumbnail
    f.inputs do
      f.input :category, :label => 'Categories', :as => :select, :collection => Category.all.map{|c| c.name }
    end
    li "Date Created: #{f.object.created_at}", class: "custom"
    li "Episode Count: #{f.object.video_count}", class: "custom"
    li "View Count: #{f.object.view_count || 0}", class: "custom"
    f.inputs :title
    f.inputs :speaker_name
    f.inputs :speaker_position
    f.inputs :description
    f.inputs :slug
    f.inputs :marketing_slug

    div class: "episode-form" do 
      h1 "Episodes"
    end
   end
    f.actions
  end

  controller do 
    def update
      series = Series.find params[:id]
      category_name = params[:series][:category]
      category = Category.find_by_name category_name
      Categorization.find_by_series_id(series.id).destroy if Categorization.find_by_series_id(series.id)
      Categorization.create series_id: series.id, category_id: category.id if category

      #update existing videos/episodes
      series.videos.each do |video|
        if params["video-#{video.id}"]
          video.update_attributes params.require("video-#{video.id}").permit(:title, :slug, :length, :url, :order)
        else
          video.destroy
        end
      end
      
      #create new episodes
      series_video_ids = series.video_ids
      (1..9).each do |n|
        if params["video-new-#{n}"] && params["video-new-#{n}"]["title"] != ""
          new_video = Video.create params.require("video-new-#{n}").permit(:title, :slug, :length, :url)
          series_video_ids << new_video.id
        end
      end

      Series.find(params[:id]).update_attributes video_ids: series_video_ids
      series.update_attributes series_params
      redirect_to admin_speakers_path
    end

    def series_params
      params.require(:series).permit(:vthumbnail, :marketing_slug, :title, :slug, :description, :public, :ready_to_notify, :speaker_name, :speaker_position)
    end

  end


end
