class MatchingController < ApplicationController
  def index
    @message_blank_matchers = []
    current_user.matchers.each do |user|
      current_user_message_rooms = MessageRoomUser.where(user_id: current_user.id).map(&:message_room)
      message_room = MessageRoomUser.where(message_room: current_user_message_rooms, user_id: user.id).map(&:message_room).first
      if message_room.blank? || message_room.messages.blank?
        @message_blank_matchers.push(user)
      end
    end
  end
end
