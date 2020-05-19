class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :message_notification
  before_action :matching_notification
  before_action :passive_relationship_notification

  def message_notification
    return unless user_signed_in?
    @message_room_users = MessageRoomUser.where(user_id: current_user.id)
    @message_room_users.each do |message_room_user|
      @unread_message = Message.where(message_room_id: message_room_user.message_room_id, unread: 'unread')
                        .where.not(user_id: current_user.id).last
      return if @unread_message.present?
    end
  end

  def matching_notification
    return unless user_signed_in?
    current_user.matchers.each do |user|
      @new_matching_flag = Relationship.find_by(follower_id: current_user.id, 
                                                     following_id: user.id, 
                                                     new_matching_flag: true)
      return if @new_matching_flag.present?
    end
  end

  def passive_relationship_notification
    return unless user_signed_in?
    current_user.passive_relationships.each do |relationship|
      next if relationship.new_arrival_flag == false
      active_relationship = Relationship.find_by(following_id: relationship.follower_id, follower_id: current_user.id)
      passive_relationship = Relationship.find_by(following_id: current_user.id, follower_id: relationship.follower_id)

        # いいねをしてくれた相手が、自分からいいねを前に送ってた場合は処理を抜ける
      next if active_relationship.present? && passive_relationship.present?
      @new_arrival_flag = relationship.new_arrival_flag
    end
  end

  protected

  def after_sign_in_path_for(resource)
    user = User.find(resource.id)
    if resource.signup_flag == true
      user.update(signup_flag: false) && about_message_from_baree_path
    else
      users_path
    end
  end
end
