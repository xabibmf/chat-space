$(document).on('turbolinks:load', function() {
  var id;

  function buildHTML(message) {
    var html = $(`<li class="message-list__message" data-message-id="${message.id}">`);
    html.append(`<div class="message-list__message__name">${message.name}</div>
    <div class="message-list__message__date">${message.created_at}</div>
    <div class="message-list__message__text">${message.body}</div>`);
    imageHtml = message.url ? `<img class="message-list__message__image" src="${message.url}">` : "";
    html.append(imageHtml);
    return html;
  }

  function need_to_update() {
    return /messages/.test(location.pathname);
  }

  function update() {
    if (!need_to_update()) {
      clearInterval(id);
      return;
    }
    var messageId = $('.message-list li:last').data('message-id');
    $.ajax({
      type: 'GET',
      url: "./messages",
      data: { messageId: messageId },
      dataType: 'json'
    })
    .done(function(data) {
      if (data.length > 0) {
        data.forEach(function(message) {
          var html = buildHTML(message);
          $('.message-list').append(html);
        });
      }
    })
    .fail(function() {
      alert('auto update error');
    })
  }

  if (need_to_update()) {
    id = setInterval(update ,10000);
  }
});
