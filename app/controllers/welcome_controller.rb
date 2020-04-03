class WelcomeController < ApplicationController
  before_action :logged_in_user
  def index
  end

  def logged_in_user
    if current_user.present?
      redirect_to users_path
    end
  end
end
