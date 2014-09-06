# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # this is a small hack; when a tr is dragged with jQuery UI sortable
  # the cells lose their width
  cells = $('.table').find('tr')[0].cells.length
  desired_width = 940 / cells + 'px'
  $('.table td').css('width', desired_width)

  $('#sortable').sortable(
    axis: 'y'
    items: '.item'

    # highlight the row on drop to indicate an update
    #stop: (e, ui) ->
    #  ui.item.children('td').effect('highlight', {}, 1000)
    #update: ->
    #  console.log('PAOK')
    #  console.log($(this).sortable('serialize'))
    #  $.post($(this).data('update-url'), $(this).sortable('serialize'))
    
    update: (e, ui) ->
      item_id = ui.item.data('item-id')
      position = ui.item.index()
      $.ajax(
        type: 'POST'
        url: $(this).data('update-url')
        dataType: 'json'

        # position is the column name used
        data: { id: item_id, page: { position_position: position } }
      )
  )