class LikesController < ApplicationController
  def sent
    @current_user = User.find_by(id: current_user.id)
    @sent_users = @current_user.following
  end

  def received
    @current_user = User.find_by(id: current_user.id)
    @received_users = @current_user.followers
  end
end
