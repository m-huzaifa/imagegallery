class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
  	redirect_to root_url, alert: exception.message
  end

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :current_password])
  end

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.admin? || current_user.client?
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

end
