$(function() {
  // メッセージルーム画面でpopper.jsを発火させないように、application.html.erbを使用してる画面のみ発火せせる
  if (window.document.body.id === 'global-body') {
    $("[data-toggle=popover]").popover({
      html : true,
      trigger: 'manual',
      content: function() {
          const content = $(this).attr("data-popover-content");
          return $(content).children(".popover-body").html();
      }
    }).on('click', function () {
      $(this).popover('toggle');
    }).on('blur', function () {
      $(this).popover('hide');
    });  
  }
});