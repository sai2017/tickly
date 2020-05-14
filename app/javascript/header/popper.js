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
    });

    $(document).on('click', function(e) {
      if  (!$(e.target).is(".header-user-image, .popover-body, .popper-ul, .popper-li")) {
        $("[data-toggle=popover]").popover('hide');
      }
    });
  }
});