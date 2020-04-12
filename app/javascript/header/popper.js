$(function() {
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
});