# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#jQuery ->
#$('.voyages_date').datepicker (dateFormat: 'dd-mm-yy')

$ ->
  $(".voyages_date").datepicker(
    altField: "#date-alt",
    altFormat: "D, dd M yy"
  )