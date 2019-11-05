var $;
$(document).on("turbolinks:load", function() {
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
      })
      .fail(function() {
        alert("error");
      });
  });
});
