class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_device_type

  helper ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  if Rails.env.production?
    before_filter :cors_preflight_check
    after_filter :cors_set_access_control_headers
    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = 'http://faymotherapp.herokuapp.com'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = 'http://faymotherapp.herokuapp.com'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
    # If this is a preflight OPTIONS request, then short-circuit the
    # request, return only the necessary headers and return an empty
    # text/plain.
    def cors_preflight_check
      if request.method == :options
        headers['Access-Control-Allow-Origin'] = 'http://faymotherapp.herokuapp.com'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        headers['Access-Control-Request-Method'] = 'http://faymotherapp.herokuapp.com'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        render :text => '', :content_type => 'text/plain'
      end
    end
  end

  helper_method :resource, :resource_name, :devise_mapping
  def resource_name
    :user
  end

  def set_device_type #allows use of @browser.mobile? in views
    request.variant = :phone if browser.mobile?
  end

  def check_mobile
    browser = Browser.new
    @mobile = browser.mobile?
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :remember_me, :email, :password, :password_confirmation) }
  end

  # if Rails.env.production?


  # if Rails.env.production?

  #   before_filter :authenticate

  #   protected

  #   def authenticate
  #     authenticate_or_request_with_http_basic do |username, password|
  #       username == "Cassandra" && password == "Cassandra"
  #     end
  #   end
  # end

end
