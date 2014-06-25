# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
$("p").click ->
  alert "PAOK"
  $.ajax
    url: "/conversations/temp"
    cache: false
    success: (html) ->
      $("#conversation").append html
      return

  return