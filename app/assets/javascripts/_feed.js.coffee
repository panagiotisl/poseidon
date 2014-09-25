time = (new Date()).getTime()

refreshLatestPartial = ->
  $.ajax url: "/refresh-latest-messages?time="+time
  time = (new Date()).getTime()
  
refreshFeedPartial = ->
  $.ajax url: "/refresh-messages-feed"
  

refreshNavbarPartial = ->
  $.ajax url: "/refresh-navbar"  
  
$(document).ready ->
  console.log 'Setting refresh 1'
  myElem = document.getElementById("messagesFeed")
  setInterval refreshFeedPartial, 300000  if myElem?
  console.log 'Setting refresh 2'
  myElem = document.getElementById("latestFeed")
  setInterval refreshLatestPartial, 300000  if myElem?
  console.log 'Setting refresh 3'
  myElem = document.getElementById("hn")
  setInterval refreshNavbarPartial, 300000  if myElem?
  
$(document).on "click", ".conversation", ->  
  url = "/notifications/small/" + $(this).attr("id")
  console.log url
  $.ajax
    url: url
    cache: false
    success: (html) ->
      $("#modalConversation").html html
      $("#myConversationModal").modal "show"