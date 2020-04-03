$(function() {
  $(document).on('click', '.user-edit-category', function() {
    $(this).siblings('.user-edit-list-none').toggle('slow');
  });
});