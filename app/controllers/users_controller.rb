class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
    @relationship = Relationship.new
  end
end
