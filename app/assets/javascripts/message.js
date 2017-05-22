$(document).on('turbolinks:load', function() {

  function buildHTML(message) {
    var html = $(`<li class="message-list__message" data-message-id="${message.id}">`);
    html.append(`<div class="message-list__message__name">${message.user.name}</div>
    <div class="message-list__message__date">${message.created_at}</div>
    <div class="message-list__message__text">${message.body}</div>`);
    imageHtml = message.image.url ? `<img class="message-list__message__image" src="${message.image.url}">` : "";
    html.append(imageHtml);
    return html;
  }

  $('.input-form').on('submit', function(e) {
    var textField = $('.input-form__message');
    var body = textField.val();
    var formData = new FormData($('#new_message').get(0));

    var image = $("input[type='file']")[0].files;
    if (!body && !image.length) {
      return;
    }
    e.preventDefault();
    var button = $('.input-form__send-button');
    $.ajax({
      type: 'POST',
      url: "./messages",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      console.log(data);
      var html = buildHTML(data.messages);
      $('.message-list').append(html);
      textField.val('');
      $("input[type='file']").val('');
    })
    .fail(function() {
      alert('error');
    })
    .always(function() {
      button.attr('disabled', false);
    })
  });

  $('.input-form__image').on('click', function() {
    $("input[type='file']").trigger('click');
  });
});
