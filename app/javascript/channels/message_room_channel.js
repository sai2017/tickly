import consumer from "./consumer"

const path = window.location.pathname.split('/');
const message_room_id = path[path.length - 1];
const messageRoomChannel = consumer.subscriptions.create({ channel: "MessageRoomChannel", message_room_id: message_room_id }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    const img_name = $('.faceicon').data('img_name');
    if (data['user_id'] != $('#message_room').data('user_id')) {
      $('.messages').append(
        `<div class='line-bc'><div class='balloon6'><div class='faceicon'><img src='${img_name}'></div><div class='chatting'><div class='says'><p id='left-message'>${data['content']}</p></div></div></div></div>`
      )
    } else {
      $('.messages').append(
        "<div class='line-bc'><div class='mycomment'><p id='right-message'>" + data['content'] + "</p></div></div>"
      )
    }
  },

  create(message) {
    const message_room_ids = $('#message_room').data('message_room_id');
    const user_id = $('#message_room').data('user_id');
    return this.perform('create', {
      message: message,
      user_id: user_id,
      message_room_id: message_room_ids
    })
  }
});

$(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
  if (event.keyCode === 13) {
    messageRoomChannel.create(event.target.value);
    event.target.value = '';
    return event.preventDefault();
  }
});
