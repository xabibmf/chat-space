$(document).on('turbolinks:load', function() {

  function buildHTML(message) {
    var html = $(`<li class="message-list__message" data-message-id="${message.id}">`);
    html.append(`<div class="message-list__message__name">${message.name}</div>
    <div class="message-list__message__date">${message.created_at}</div>
    <div class="message-list__message__text">${message.body}</div>`);
    imageHtml = message.url ? `<img class="message-list__message__image" src="${message.url}">` : "";
    html.append(imageHtml);
    return html;
  }

  function update() {
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
      alert('error');
    })
  }

  if(/messages/.test(location.pathname)){
    setInterval(update ,10000)
  }
});
