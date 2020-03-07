class MessageRoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_fromにするとメッセージが重複してしまう
    stream_for "message_room_#{params[:message_room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create! content: data['message'], user_id: current_user.id, message_room_id: data["message_room_id"]
    MessageRoomChannel.broadcast_to "message_room_#{data['message_room_id']}", content: render_message(message)
  end

  private
    def render_message(message)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, current_user: message.user })
    end
end
