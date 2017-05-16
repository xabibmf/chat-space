$(function() {

  function appendCandidate(user) {
    var html = $('<li data-user_id="' + user.id + '" class="chat-group-user clearfix">');
    html.append('<div class="chat-group-user__name">' + user.name + '</div>');
    html.append('<div class="chat-group-user__btn chat-group-user__btn--add">追加</div>');
    return html;
  }

  function appendList(user_id, user_name) {
    var html = $('<li data-user_id="' + user_id + '" class="chat-group-user clearfix">');
    html.append('<div class="chat-group-user__name">' + user_name + '</div>');
    html.append('<div class="chat-group-user__btn chat-group-user__btn--remove">削除</div>');
    html.append('<input type="hidden" name="user_ids[]" value="' + user_id + '">')
    return html;
  }

  $("#chat-group-form__input").on("keyup", function(e) {
    var input = $("#chat-group-form__input").val();
    e.preventDefault();
    $.ajax({
      type: 'GET',
      url: "/groups/new",
      data: {
        name: input
      },
      dataType: 'json'
    })
    .done(function(data) {
      var member = $('.chat-member-candidate');
      member.empty();
      var current_user_id = member.data('current');
      data.forEach(function(user) {
        if (user.id != current_user_id) {
          var html = appendCandidate(user);
          member.append(html);
        }
      })
    })
    .fail(function() {
      alert('error');
    })
  });

  $('.chat-member-candidate').on("click", ".chat-group-user__btn--add", function() {
    var add_user = $(this).parent("li");
    var html = appendList(add_user.data('user_id'), add_user.children('.chat-group-user__name').text());
    html.appendTo('.chat-member-list');
    add_user.remove();
  });

  $('.chat-member-list').on("click", ".chat-group-user__btn--remove", function() {
    var remove_user = $(this).parent("li");
    remove_user.remove();
  });
});
