class MessagesController < ApplicationController

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
  end
end
