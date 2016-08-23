ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation
  menu false
  
  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do 
    def update
      if params[:admin_user][:password] == ""
        params[:admin_user].delete :password
      end
      admin_user = AdminUser.find params[:id]
      admin_user.update_attributes params.require[:admin_user].permit(:email, :password, :password_confirmation)
      redirect_to '/admin/dashboard'
    end

    def index
      redirect_to '/admin/dashboard'
    end

    def destroy
      admin_user = AdminUser.find params[:id]
      admin_user.destroy
      redirect_to '/admin/dashboard'
    end

    def create
      AdminUser.create params[:admin_user]
      redirect_to '/admin/dashboard'
    end
  end

end
