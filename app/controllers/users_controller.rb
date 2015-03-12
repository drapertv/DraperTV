class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update]
  before_filter :validate_authorization_for_user, only: [:edit, :update]
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = current_user
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def profile_edit
    @user = User.find(params[:id])
  end
  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json

  def update
    # authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    params[:user] = params[:user].except(:role_ids)
    respond_to do |format|
      if @user.update_attributes(user_params)
        @user.update_plan(role) unless role.nil?
        format.html { redirect_to profile_edit_path(@user), notice: 'User was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_plan
    @user = current_user

    role_id = params[:user][:role_ids] unless params[:user].nil? || params[:user][:role_ids].nil?
    role = Role.find_by_id role_id unless role_id.nil?

    authorized = !role.nil? && (role.name != 'admin' || current_user.roles.first.name == 'admin')

    if authorized && @user.update_plan(role)
      redirect_to edit_user_registration_path, :notice => 'Updated plan.'
    else
      flash.alert = 'Unable to update plan.'
      redirect_to edit_user_registration_path
    end
  end

  def update_card
    @user = current_user
    @user.stripe_token = params[:user][:stripe_token]
    if @user.save
      redirect_to edit_user_registration_path, :notice => 'Updated card.'
    else
      flash.alert = 'Unable to update card.'
      redirect_to edit_user_registration_path
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def validate_authorization_for_user
    redirect_to root_path unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:avatar,:remember_me,:bio,:role,:stripe_token, :coupon)
  end


end
