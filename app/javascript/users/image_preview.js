$(function(){
  fileField = $('#file')
  // 選択された画像を取得し表示
  $(fileField).on('change', fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
    $preview = $("#img_field");

    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: "150px",
          height: "150px",
          class: "preview",
          title: file.name,
          style: "border-radius:50%"
        }));
      };
    })(file);
    reader.readAsDataURL(file);
    console.log($preview);
  });
});