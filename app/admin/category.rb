ActiveAdmin.register Category do
  menu false
  permit_params :name


  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Livestream Details" do
     f.inputs :name
    end
    f.actions
  end

  controller do 
    def update
      cat = Category.find params[:id]
      cat.update_attributes params[:category]
      redirect_to '/admin/dashboard'
    end

    def index
      redirect_to '/admin/dashboard'
    end

    def create
      Category.create params[:category]
      redirect_to '/admin/dashboard'
    end

    def destroy
      cat = Category.find params[:id]
      cat.destroy
      redirect_to '/admin/dashboard'
    end
  end
end