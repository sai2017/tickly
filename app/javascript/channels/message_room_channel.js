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
    const image_name = $('#direct_messages').data('image_name');
    const message_user_id = $('#direct_messages').data('message_user_id')

    const formatDate = (date, format) => {
      format = format.replace(/MM/, date.getMonth() + 1);
      format = format.replace(/DD/, date.getDate());
      format = format.replace(/hh/, date.getHours());
      format = format.replace(/mm/, date.getMinutes());
      return format;
    }
    const dateNow = formatDate(new Date(), 'MM/DD hh:mm');

    if (data['user_id'] != $('#direct_messages').data('user_id')) {
      $(".no-messages").remove();
      $('.messages').append(
        `<div class='line-bc'>
           <div class='balloon6'>
             <div class='faceicon'>
               <a href='/users/${message_user_id}'>
                 <img src='${image_name}'>
               </a>
             </div>
             <div class='chatting'>
               <div class='says'>
                 <p id='left-message'>${data['content']}</p>
               </div>
             </div>
             <div class="time-sent-message">${dateNow}</div>
           </div>
         </div>`
      )
      $('html, body').animate({
        scrollTop: $(document).height()
      },1500);
      return false;
    } else {
      $(".no-messages").remove();
      $('.messages').append(
        `<div class='line-bc'>
           <div class='mycomment'>
             <div class='time-sent-message'>
               ${dateNow}
             </div>
             <p id='right-message'>${data['content']}</p>
           </div>
         </div>`
      )
      $('html, body').animate({
        scrollTop: $(document).height()
      },1500);
      return false;
    }
  },

  create(message) {
    const message_room_ids = $('#direct_messages').data('room_id');
    const user_id = $('#direct_messages').data('user_id');    
    return this.perform('create', {
      message: message,
      user_id: user_id,
      message_room_id: message_room_ids
    })
  }
});

$(document).on('click', '#btn_id', function(event) {
  const content = $('.message-content').val();
  messageRoomChannel.create(content);
  $('.message-content').val('');
  $("#btn_id").attr("disabled", true);
  return event.preventDefault();
});
