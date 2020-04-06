class RelationshipsController < ApplicationController

  def create
    @like_point = LikePoint.find_by(user_id: current_user.id)
    if @like_point.balance > 0
      update_balance = @like_point.balance - 1
      @like_point.update(balance: update_balance)
      current_user.active_relationships.create(create_params)
    else
      redirect_to users_path
    end
  end

  private

  def create_params
    { following_id: params[:following_id] }
  end
end
