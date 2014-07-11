refreshFeedPartial = ->
  $.ajax url: "refresh-messages-feed"
  
$(document).ready ->
  myElem = document.getElementById("messagesFeed")
  setInterval refreshFeedPartial, 30000  if myElem?
  
$(document).on "click", ".conversation", ->  
  url = "/conversations/small/" + $(this).attr("id")
  console.log url
  $.ajax
    url: url
    cache: false
    success: (html) ->
      $("#conversation").html html