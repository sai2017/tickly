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
    end
  end

  private
    def render_message(message)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, current_user: message.user })
    end
end
