$(function() {
  $(document).on('click', '.user-edit-category', function() {
    $(this).siblings('.user-edit-list-none').toggle('slow');
  });

  // メニュー領域外をクリックしたらメニューを閉じる
  $(document).on('click touchend', function(event) {
    if (!$(event.target).closest('.user-edit-category').length && 
        !$(event.target).closest('.user-edit-list-none').length) {
      $('.user-edit-category').siblings('.user-edit-list-none').slideUp('slow');
    }
  });
});