$(document).ready ->
  $(".conversation").click ->
    url = "/conversations/small/" + $(this).attr("id")
    console.log url
    $.ajax
      url: url
      cache: false
      success: (html) ->
        $("#conversation").html html