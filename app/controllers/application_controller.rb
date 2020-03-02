class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: %i(name self_introduction sex img_name job_category original_experience purpose_of_working weakness want_to_do want_to_connect meet_area))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(name self_introduction sex img_name job_category original_experience purpose_of_working weakness want_to_do want_to_connect meet_area))
  end

  def after_sign_in_path_for(resource)
    users_path
  end
end
