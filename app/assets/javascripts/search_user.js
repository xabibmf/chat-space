$(document).on('turbolinks:load', function() {
  var search_result;

  function appendCandidate(user) {
    var html = $(`<li data-user-id="${user.id}" class="chat-group-user clearfix">`);
    html.append(`<div class="chat-group-user__name">${user.name}</div>
    <div class="chat-group-user__btn chat-group-user__btn--add">追加</div>`);
    return html;
  }

  function appendList(user_id, user_name) {
    var html = $(`<li data-user-id="${user_id}" class="chat-group-user clearfix">`);
    html.append(`<div class="chat-group-user__name">${user_name}</div>
    <div class="chat-group-user__btn chat-group-user__btn--remove">削除</div>
    <input type="hidden" name="user_ids[]" value="${user_id}">`);
    return html;
  }

  function showCandidate(data, empty_flg) {
    var member = $('.chat-member-candidate');
    member.empty();
    var current_user_id = member.data('user-id')
    if (empty_flg) {
      member_ids = [];
      $('li.chat-group-user').each(function() {
        member_ids.push($(this).data('user-id'));
      })
      data.forEach(function(user) {
        if ($.inArray(user.id, member_ids) < 0) {
          var html = appendCandidate(user);
          member.append(html);
        }
      })
    }
  }

  function isEmptyMemberField() {
    var input = $("#chat-group-form__input").val();
    if (input) {
      return true;
    } else {
      return false;
    }
  }

  $("#chat-group-form__input").on("keyup", function() {
    var input = $("#chat-group-form__input").val();
    $.ajax({
      type: 'GET',
      url: "/user/search",
      data: {
        name: input
      },
      dataType: 'json'
    })
    .done(function(data) {
      search_result = data;
      showCandidate(search_result, isEmptyMemberField());
    })
    .fail(function() {
      alert('error');
    })
  });

  $('.chat-member-candidate').on("click", ".chat-group-user__btn--add", function() {
    var add_user = $(this).parent("li");
    var html = appendList(add_user.data('user-id'), add_user.children('.chat-group-user__name').text());
    html.appendTo('.chat-member-list');
    add_user.remove();
  });

  $('.chat-member-list').on("click", ".chat-group-user__btn--remove", function() {
    var remove_user = $(this).parent("li");
    remove_user.remove();
    showCandidate(search_result, isEmptyMemberField());
  });
});
