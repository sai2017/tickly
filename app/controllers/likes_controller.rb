class LikesController < ApplicationController
  def sent
    @current_user = User.find_by(id: current_user.id)
    all_sent_users = @current_user.following
                                  .includes(:active_relationships)
                                  .order("relationships.created_at desc")
    next_sent_users = all_sent_users.map do |sent_user|
      active_relationship = Relationship.find_by(following_id: sent_user.id, follower_id: current_user.id)
      passive_relationship = Relationship.find_by(following_id: current_user.id, follower_id: sent_user.id)
  
      # 自分からいいねして相手からのいいねがない場合は、自分がいいねしたユーザーを返す
      if active_relationship.present? && passive_relationship.blank?
        sent_user
      # マッチングしていて、自分の方が先にいいねしてた場合は、自分がいいねしたユーザーを返す
      elsif active_relationship.created_at < passive_relationship.created_at
        sent_user
      end
    end
    sent_users = next_sent_users.compact
    @sent_users = Kaminari.paginate_array(sent_users).page(params[:page]).per(10)
  end

  def received
    @current_user = User.find_by(id: current_user.id)
    all_received_users = @current_user.followers
                                      .includes(:passive_relationships)
                                      .order("relationships.created_at desc")
    next_received_users = all_received_users.map do |received_user|
      active_relationship = Relationship.find_by(following_id: received_user.id, follower_id: current_user.id)
      passive_relationship = Relationship.find_by(following_id: current_user.id, follower_id: received_user.id)
  
      # 相手からいいねが来ていて、自分がいいねしてない場合は、いいねしてくれたユーザーを返す
      if passive_relationship.present? && active_relationship.blank?
        received_user
      # マッチングしていて、相手の方が先にいいねしてた場合は、いいねしてくれたユーザーを返す
      elsif active_relationship.created_at > passive_relationship.created_at
        received_user
      end
    end
    received_users = next_received_users.compact
    @received_users = Kaminari.paginate_array(received_users).page(params[:page]).per(10)
  end
end
