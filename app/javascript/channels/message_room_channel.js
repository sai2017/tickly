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
    return $('.messages').append(data['content']);
  },

  speak: function(message) {
    return this.perform('speak', {
      message: message,
      message_room_id: message_room_id
    });
  }
});

$(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
  if (event.keyCode === 13) {
    messageRoomChannel.speak(event.target.value);
    event.target.value = '';
    return event.preventDefault();
  }
});
