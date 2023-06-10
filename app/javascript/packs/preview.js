// 投稿新規・編集の画像表示
$(document).on('turbolinks:load', function() {
  $("#image-preview").hide();

  function showPreview(event) {
    var file = event.target.files[0];
    var reader = new FileReader();

    reader.onload = function(e) {
      var previewElement = $("#image-preview");
      previewElement.attr("src", e.target.result);
      $(".card-img").hide(); // card-imgクラスを持つ要素を非表示
      previewElement.show();　// 画像を表示
    };

    if (file) {
      reader.readAsDataURL(file);  // ファイルを読み込んでData URLに変換
    }
  }

  var fileInput = $("#counseling_post_image");
  fileInput.on("change", showPreview);
});




// ユーザー編集の画像表示
$(document).on('turbolinks:load', function() {
  $("#user-image-preview").hide();

  function showPreview(event) {
    var file = event.target.files[0];
    var reader = new FileReader();

    reader.onload = function(e) {
      var previewElement = $("#user-image-preview");
      previewElement.attr("src", e.target.result);
      $(".user-card-img").hide(); // user-card-imgクラスを持つ要素を非表示
      previewElement.show();　// 画像を表示
    };

    if (file) {
      reader.readAsDataURL(file);  // ファイルを読み込んでData URLに変換
    }
  }

  var fileInput = $("#user_profile_image");
  fileInput.on("change", showPreview);
});