var $;
$(document).on("turbolinks:load", function() {
  var searchResult = $("#user-search-result");
  var chatMemberList = $(".chat-group-users");

  function appendUser(user) {
    var html = `
    <div class="chat-group-user">
      <p class="chat-group-user__name">${user.user_name}</p>
      <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.user_id}" data-user-name="${user.user_name}" >追加</a>
    </div>
    `;
    searchResult.append(html);
  }

  function appendErrMsgToHTML(text) {
    var html = `
    <div class="chat-group-user">
      <p class="chat-group-user__name">${text}</p>
    </div>
    `;
    searchResult.append(html);
  }

  function appendMember(userId, userName) {
    var html = `
    <div class="chat-group-user js-chat-member" id="chat-group-user-${userId}" >
      <input name="group[user_ids][]" type="hidden" value="${userId}" />
      <p class="chat-group-user__name">${userName}</p>
      <a class="user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn" >削除</a >
    </div>
    `;
    chatMemberList.append(html);
  }

  $("#user-search-field").on("input", function() {
    var input = this.value;
    console.log(input);
    $.ajax({
      type: "GET",
      url: "/users",
      data: { keyword: input },
      dataType: "json"
    })
      .done(function(data) {
        console.log(data);
        $("#user-search-result").empty();
        if (data.length !== 0) {
          data.forEach(function(user) {
            appendUser(user);
          });
        } else {
          appendErrMsgToHTML("一致するユーザーが見つかりませんでした");
          console.log("一致なし");
        }
      })
      .fail(function() {
        alert("ユーザー検索に失敗しました");
      });
  });

  $(document).on("click", ".chat-group-user__btn--add", function() {
    console.log(this);
    var userId = this.dataset.userId;
    var userName = this.dataset.userName;
    this.parentElement.remove();
    appendMember(userId, userName);
  });
});
