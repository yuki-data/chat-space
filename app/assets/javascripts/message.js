var $;
$(function() {
  $("#new_message").on("submit", function(e) {
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr("action");
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false
    })
      .done(function(data) {
        console.log(data);
      })
      .fail(function() {
        alert("メッセージ送信に失敗しました");
      });
    return false;
  });
});
