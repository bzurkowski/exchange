class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push %i(username student_number)
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path and return unless current_user.present?
    redirect_to root_path, flash: { error: I18n.t(".access_denied") } unless current_user.admin?
  end

  def after_sign_in_path_for(resource)
    offers_path
  end
end
