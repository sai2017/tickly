class ApplicationController < ActionController::Base
  protect_from_forgery except: :message_notification
  protect_from_forgery except: :matching_notification
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
      current_user_message_rooms = MessageRoomUser.where(user_id: current_user.id).map(&:message_room)
      @message_room = MessageRoomUser.where(message_room: current_user_message_rooms, user_id: user.id)
                                     .map(&:message_room).first
      return if @message_room.blank?
    end
  end

  def passive_relationship_notification
    return unless user_signed_in?
    current_user.passive_relationships.each do |relationship|
      next if relationship.new_arrival_flag == false
      # いいねをしてくれた相手が、自分からいいねを前に送ってた場合は処理を抜ける
      next if relationship.following_id == current_user.id
      @new_arrival_flag = relationship.new_arrival_flag
    end
  end

  protected

  def after_sign_in_path_for(resource)
    users_path
  end
end
