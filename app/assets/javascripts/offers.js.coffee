# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.offer_value').change ->
    $(this).next().next().val($(this).val()*$(this).next().text()).change();
    
