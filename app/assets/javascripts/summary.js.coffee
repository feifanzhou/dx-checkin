$('body').on('click', '.Name', (e) ->
  $('li.Active').removeClass('Active')
  $(e.target).addClass('Active')
  id = $(e.target).attr('data-id')
  $.get ('/kids/' + id), (resp) -> document.getElementById('card').innerHTML = resp
  $('#rejectButton').attr('data-id', id)
  $('#acceptButton').attr('data-id', id)
)


saveStatus = (id, status) ->
  accepted = if status == 'left' then false else true
  $.ajax
    url: '/kids/' + id
    method: 'PATCH'
    dataType: 'JSON'
    data: { kid: { is_accepted: accepted } }

$('body').on('click', '#rejectButton', (e) ->
  saveStatus($('li.Active').attr('data-id'), 'left')
  $('li.Active').removeClass('Accepted').addClass('Rejected')
)
$('body').on('click', '#acceptButton', (e) ->
  saveStatus($('li.Active').attr('data-id'), 'right')
  $('li.Active').removeClass('Rejected').addClass('Accepted')
)