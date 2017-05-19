$(document).on('turbolinks:load', function() {

  function toLocaleString(date) {
    return [
      date.getFullYear(),
      ('0' + (date.getMonth() + 1)).slice(-2),
      ('0' + date.getDate()).slice(-2)
    ].join('-') + ' ' + date.toLocaleTimeString();
  }

  function buildHTML(message) {
    var html = $(`<li class="message-list__message" data-message-id="${message.id}">`);
    html.append(`<div class="message-list__message__name">${message.user.name}</div>
    <div class="message-list__message__date">${toLocaleString(new Date(Date.parse(message.created_at)))}</div>
    <div class="message-list__message__text">${message.body}</div>
    ${message.image.url ? `<img class="message-list__message__image" src="${message.image.url}">` : ""}`);
    return html;
  }

  function update() {
    var messageId = $('.message-list li:last').data('message-id');
    $.ajax({
      type: 'GET',
      url: "./reload",
      data: { messageId: messageId },
      dataType: 'json'
    })
    .done(function(data) {
      if (data.messages.length > 0) {
        data.messages.forEach(function(message) {
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