$(function() {

  function toLocaleString(date) {
    return [
      date.getFullYear(),
      ('0' + (date.getMonth() + 1)).slice(-2),
      ('0' + date.getDate()).slice(-2)
    ].join('-') + ' ' + date.toLocaleTimeString();
  }

  function buildHTML(message) {
    var html = $('<li class="message-list__message">')
    html.append('<div class="message-list__message__name">' + message.user.name + '</div>');
    html.append('<div class="message-list__message__date">' + toLocaleString(new Date(Date.parse(message.created_at))) + '</div>');
    html.append('<div class="message-list__message__text">' + message.body + '</div>');
    return html;
  }

  $('.input-form').on('submit', function(e) {
    var textField = $('.input-form__message');
    var body = textField.val();
    if (!body) {
      return;
    }
    e.preventDefault();
    var button = $('.input-form__send-button');
    $.ajax({
      type: 'POST',
      url: "./messages.json",
      data: {
        message: {
          body: body
        }
      },
      dataType: 'json'
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.message-list').append(html);
      textField.val('');
      button.attr('disabled', false);
    })
    .fail(function() {
      alert('error');
    })
  });
});
