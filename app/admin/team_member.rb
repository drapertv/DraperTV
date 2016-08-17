ActiveAdmin.register TeamMember do
  permit_params :name, :email, :position, :linkedin, :current, :profilepic
  menu false
  index do
    selectable_column
    id_column
    column :name
    column :email
    actions
  end


  form do |f|
    f.inputs "Member Details" do
      f.input :name
      f.inputs :profilepic
      f.input :position
      f.input :email
      f.input :linkedin
      f.input :current
    end
    f.actions
  end

  controller do 
    def update
      team_member = TeamMember.find params[:id]
      team_member.update_attributes params[:team_member]
      redirect_to '/admin/dashboard'
    end

    def destroy
      team_member = TeamMember.find params[:id]
      team_member.destroy
      redirect_to '/admin/dashboard'
    end

    def create
      TeamMember.create params[:team_member]
      redirect_to '/admin/dashboard'
    end

  end

end
