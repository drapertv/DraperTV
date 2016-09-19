ActiveAdmin.register Session do
  menu false
  permit_params :name


  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Session Details" do
     f.inputs :name
    end
    f.actions
  end

  controller do 
    def update
      sess = Session.find params[:id]
      sess.update_attributes params[:session]
      redirect_to '/admin/dashboard'
    end

    def index
      redirect_to '/admin/dashboard'
    end

    def create
      Session.create params[:session]
      redirect_to '/admin/dashboard'
    end

    def destroy
      sess = Session.find params[:id]
      sess.destroy
      redirect_to '/admin/dashboard'
    end
  end
end