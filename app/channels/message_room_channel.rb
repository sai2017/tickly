class MessageRoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_fromにするとメッセージが重複してしまう
    stream_for "message_room_#{params[:message_room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(data)
    message = Message.create!(
      content: data["message"],
      user_id: data["user_id"],
      message_room_id: data["message_room_id"]
    )
    if message.save
      MessageRoomChannel.broadcast_to "message_room_#{params[:message_room_id]}", content: data['message'], user_id: data['user_id']
      target_room_user = MessageRoomUser.where(message_room_id: message.message_room_id)
                                        .where.not(user_id: message.user.id).last
      receive_user = User.find(target_room_user.user_id)
      receive_user_setting = MailNotificationSetting.find_by(user_id: receive_user.id)
      if receive_user_setting.message_flag == true
        MessageMailer.message_to_user(message.user, receive_user).deliver
      end
    end

    # 今回が最初のメッセージの作成（２通目が空）だったら、お互いのnew_matching_flagをfalseにする
    if Message.where(message_room_id: message.message_room_id).second.blank?
      active_relationship = Relationship.find_by(following_id: receive_user.id, follower_id: message.user.id)
      passive_relationship = Relationship.find_by(following_id: message.user.id, follower_id: receive_user.id)
      active_relationship.update(new_matching_flag: false)
      passive_relationship.update(new_matching_flag: false)
    end
  end
end
