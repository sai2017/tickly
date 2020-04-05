class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :message_notification
  before_action :matching_notification
  protect_from_forgery with: :exception

  def message_notification
    @message_room_users = MessageRoomUser.where(user_id: current_user.id)
    @message_room_users.each do |message_room_user|
      @unread_message = Message.where(message_room_id: message_room_user.message_room_id, unread: 'unread')
                        .where.not(user_id: current_user.id).last
      return if @unread_message.present?
    end
  end

  def matching_notification
    current_user.matchers.each do |user|
      current_user_message_rooms = MessageRoomUser.where(user_id: current_user.id).map(&:message_room)
      @message_room = MessageRoomUser.where(message_room: current_user_message_rooms, user_id: user.id)
                                     .map(&:message_room).first
      return if @message_room.blank?
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, :birthday, :age, :company_name, :self_introduction, :img_name, :occupation, 
      :catch_copy, :original_experience, :purpose_of_working, :weakness, 
      :want_to_do, :want_to_connect, :communication_method, :purpose_of_use, 
      :prefecture_id, :remove_img_name, communication_method_ids: [], purpose_of_use_ids: [],
      job_category_ids: []
    ])
  end

  def after_sign_in_path_for(resource)
    users_path
  end
end
