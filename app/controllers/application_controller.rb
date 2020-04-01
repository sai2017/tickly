class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, :age, :company_name, :self_introduction, :img_name, :job_category, 
      :catch_copy, :original_experience, :purpose_of_working, :weakness, 
      :want_to_do, :want_to_connect, :communication_method, :purpose_of_use, 
      :prefecture_id, :remove_img_name, communication_method_ids: [], purpose_of_use_ids: []
    ])
  end

  def after_sign_in_path_for(resource)
    users_path
  end
end
