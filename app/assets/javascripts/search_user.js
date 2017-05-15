$(function() {

  function appendList(user_name) {
    var html = $('<li class="chat-group-user clearfix">');
    html.append('<div class="chat-group-user__name">' + user_name + '</div>');
    html.append('<div class="chat-group-user__btn chat-group-user__btn--add">追加</div>');
    return html;
  }

  $("#chat-group-form__input").on("keyup", function(e) {
    var input = $("#chat-group-form__input").val();
    console.log(input);
    e.preventDefault();
    $.ajax({
      type: 'GET',
      url: "./new.json",
      data: {
        name: input
      },
      dataType: 'json'
    })
    .done(function(data) {
      var member = $('.chat-member-list');
      member.empty();
      data.forEach(function(user) {
        var html = appendList(user.name);
        member.append(html);
      })
    })
    .fail(function() {
      alert('error');
    })
    .always(function() {

    })
  });
});
