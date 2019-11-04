var $;
$(function() {
  function buildHTML(message) {
    var image_tag = message.image_url
      ? `<img src="${message.image_url}" alt="${message.image_alt}">`
      : "";

    var html = `
    <div class="chat__message">
      <div class="chat__message__info">
        <div class="chat__message__info__username">${message.user_name}</div>
        <div class="chat__message__info__date">${message.updated_at}</div>
      </div>
      <div class="chat__message__text">${message.content}</div>
      ${image_tag}
    </div>
    `;
    return html;
  }

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
        var html = buildHTML(data);
        var chat = $(".chat");
        chat.append(html);
        $("#message_content").val("");
        $("#message_image").val("");
      })
      .fail(function() {
        alert("メッセージ送信に失敗しました");
      });
    return false;
  });
});
