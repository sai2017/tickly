class RelationshipsController < ApplicationController

  def create
    @like_point = LikePoint.find_by(user_id: current_user.id)
    if @like_point.balance > 0
      update_balance = @like_point.balance - 1
      @like_point.update(balance: update_balance)
      current_user.active_relationships.create(create_params)
      Relationship.find_user_send_mail(params[:following_id], current_user)
    else
      redirect_to user_path(params[:following_id])
      flash[:error] = 'いいねポイントが足りません。'
    end
  end

  private

  def create_params
    { following_id: params[:following_id] }
  end
end
