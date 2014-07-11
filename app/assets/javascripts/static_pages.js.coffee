# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

refreshLatestPartial = ->
  $.ajax url: "/refresh-latest-messages"
  
$(document).ready ->
  myElem = document.getElementById("latestFeed")
  setInterval refreshLatestPartial, 300000  if myElem?