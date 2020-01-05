var $, chatUpdateScheduler;

$(document).on("turbolinks:load", function() {
  function isChatUrl(pathname) {
    var urlPatternChatView = /\/groups\/\d+\/messages/;
    if (pathname.match(urlPatternChatView)) {
      return true;
    }
  }

  function buildHTML(message) {
    var image_tag = message.image_url
      ? `<img src="${message.image_url}" alt="${message.image_alt}">`
      : "";

    var html = `
    <div class="chat__message" data-message-id="${message.message_id}">
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

  function updateMessages() {
    var last_message = $(".chat__message").last();
    var latest_message_id = last_message.data("message-id");
    var url = location.pathname.replace("/messages", "/api/messages");
    $.ajax({
      type: "GET",
      url: url,
      data: { latest_message_id: latest_message_id },
      dataType: "json"
    })
      .done(function(data) {
        var chat = $(".chat");
        if (data.length !== 0) {
          data.forEach(function(message) {
            var html = buildHTML(message);
            chat.append(html);
          });
          chat.animate({ scrollTop: chat[0].scrollHeight }, 100);
        }
      })
      .fail(function() {
        alert("データの取得に失敗しました");
      });
  }

  $("#new_message").on("submit", function(e) {
    e.preventDefault();
    $(this).prop("disabled", true);
    var formData = new FormData(this);
    var url = this.action;
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false
    })
      .done(function(data) {
        if (data.status == "success") {
          var html = buildHTML(data);
          var chat = $(".chat");
          chat.append(html);
          $("#new_message")[0].reset();
          chat.animate({ scrollTop: chat[0].scrollHeight }, 100);
        } else {
          alert(data.error_message);
        }
      })
      .fail(function() {
        alert("メッセージ送信に失敗しました");
      });
  });

  if (chatUpdateScheduler) {
    clearInterval(chatUpdateScheduler);
  }

  if (isChatUrl(location.pathname)) {
    chatUpdateScheduler = setInterval(updateMessages, 5000);
  }
});
