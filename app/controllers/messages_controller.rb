class MessagesController < ApplicationController

  def index
    desc_message_users = User
    .joins("left join message_room_users on users.id = message_room_users.user_id")
    .joins("left join messages on message_room_users.message_room_id = messages.message_room_id")
    .order("messages.created_at desc")

    message_exist_matchers = []
    current_user.matchers.each do |user|
      current_user_message_rooms = MessageRoomUser.where(user_id: current_user.id).map(&:message_room)
      message_room = MessageRoomUser.where(message_room: current_user_message_rooms, user_id: user.id).map(&:message_room).first
      if message_room.present? && message_room.messages.present?
        message_exist_matchers.push(user)
      end
    end
    @desc_message_exist_matchers = desc_message_users & message_exist_matchers
  end

  def create
    # 自分の持っているチャットルームを取得
    current_user_message_rooms = MessageRoomUser.where(user_id: current_user.id).map(&:message_room)
    # 自分の持っているチャットルームからチャット相手のいるルームを探す
    message_room = MessageRoomUser.where(message_room: current_user_message_rooms, user_id: params[:user_id]).map(&:message_room).first
    # なければ作成する
    if message_room.blank?
      # message_roomsテーブルにレコードを作成
      message_room = MessageRoom.create
      MessageRoomUser.create(message_room: message_room, user_id: current_user.id)
      MessageRoomUser.create(message_room: message_room, user_id: params[:user_id])
    end
    # チャットルームへ遷移させる
    redirect_to action: :show, id: message_room.id
  end

  # showアクションを追加する
  def show
    # チャット相手の情報を取得する
    message_room = MessageRoom.find_by(id: params[:id])
    @message_room_user = message_room.message_room_users.
      where.not(user_id: current_user.id).first.user
    @messages = Message.where(message_room: message_room).order(:created_at)
    unread_received_messages = @messages.where(user_id: @message_room_user.id, unread: 'unread')
    unread_received_messages.update_all(unread: :read) if unread_received_messages.present?
  end
end
