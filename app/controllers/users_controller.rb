class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @job_categories = JobCategory.all
    @users = @q.result(distinct: true).includes(:job_categories).page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
    @relationship = Relationship.new
  end
end
