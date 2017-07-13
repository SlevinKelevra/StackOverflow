ready = ->

  $('.vote_link').on 'ajax:success', (e, data, status, xhr) ->
    div_id = '#rating-' + data.controller + '-' + data.id
    $("#{div_id} p").html("Rating: #{data.content}")
  .on 'ajax:error', (e, response, status, xhr) ->
    data = response.responseJSON
    div_id = '#error-' + data.controller + '-' + data.id
    $(div_id).html(data.content)


$(document).ready(ready);
$(document).on('turbolonks:load', ready);