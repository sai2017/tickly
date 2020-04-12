$(function() {
  if (window.document.body.id === 'chat-page-body') {
    // 画面最下部へ遷移
    $(window).scrollTop($(document).height());

    // 送信ボタンをデフォルトで無効
    $("#btn_id").attr("disabled", true);
  
    // 文字入力があれば送信ボタンを活性にし、空文字であれば非活性に
    const input = $('.message-content');
    input.on('input', function() {
      let value = input.val();
      if (value) {
        $("#btn_id").attr("disabled", false);
      } else {
        $("#btn_id").attr("disabled", true);
      }
    });  
  }
});
