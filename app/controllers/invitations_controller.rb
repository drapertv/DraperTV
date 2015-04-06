class Users::InvitationsController < Devise::InvitationsController
  def update
    @user = User.find params[:id]
    @user.update_attributes params[:user]
    binding.pry
    redirect_to root_path

  end
end