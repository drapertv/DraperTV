class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user = current_user
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def profile_edit
    @user = User.find(params[:id])
    @wrong_password = params[:message] == "wrong_password"
    @bad_match = params[:message] == "bad_match"
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete_if {|k,v| v == ""}
    if params[:user][:password]
      if !current_user.valid_password? params[:current_password]
        redirect_to profile_edit_path(id: current_user.id, message: "wrong_password") and return
      end
      
      if params[:user][:password] != params[:user][:password_confirmation]
        redirect_to profile_edit_path(id: current_user.id, message: "bad_match") and return
      end
    end
    
    respond_to do |format|
      if @user.update_attributes(user_params)
        sign_in(@user, :bypass => true)
        format.html { redirect_to profile_edit_path(@user, message: "password_change_successful"), notice: 'User was successfully updated.' }
      else
        redirect_to profile_edit_path(@user)
      end
    end
  end

  def accept_invite
    User.accept_invitation!(user_params)
    sign_in User.find(params[:id])
    redirect_to root_path(welcome: true)
  end

  private
  
  def user_params
    params.require(:user).permit(:current_password, :invitation_token, :invited_by_id, :name, :email, :password, :password_confirmation,:avatar,:remember_me,:bio,:stripe_token, :coupon,:role)
  end
end
