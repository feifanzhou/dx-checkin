loadedPage = 0
processed = 0
loadNextPage = ->
  container = document.getElementById('kids')
  container.innerHTML = "<span class='fa fa-spin fa-circle-o-notch fa-3x'></span>"
  nextPage = loadedPage + 1
  $.get ('/kids?p=' + nextPage), (resp) ->
    processed = 0
    container.innerHTML = resp
    showFirstKid()
loadNextPage()

showFirstKid = ->
  $firstKid = $('.Kid').first()
  if $firstKid.hasClass('Visible')
    $firstKid.remove()
    showFirstKid()
  $firstKid.addClass('Visible')

finishProcessingKid = (kid, direction) ->
  id = kid.attr('data-id')
  processed += 1
  accepted = if direction == 'left' then false else true
  $.ajax
    url: '/kids/' + id
    method: 'PATCH'
    dataType: 'JSON'
    data: { kid: { is_accepted: accepted } }
  setTimeout((->
    kid.remove()
    showFirstKid()
    loadNextPage() if $('.Kid').length == 0
  ), 260)

$('body').on('click', '#rejectButton', ->
  $kid = $('.Kid').first()
  $kid.addClass('Left')
  finishProcessingKid($kid, 'left')
)
$('body').on('click', '#acceptButton', ->
  $kid = $('.Kid').first()
  $kid.addClass('Right')
  finishProcessingKid($kid, 'right')
)