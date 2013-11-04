# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#shipping_company').hide()
  $('#agent').hide()
  type = $('#user_type :selected').text()
  if type == 'Shipping Company Employee'
    $('#shipping_company').show()
  else if type == 'Agent/Supplier Employee'
    $('#agent').show()
  $('#user_type').change ->
    $('#agent').hide()
    $("#user_agent_id")[0].options[0].selected = true;
    $('#shipping_company').hide()
    $("#user_shipping_company_id")[0].options[0].selected = true;
    type = $('#user_type :selected').text()
    if type == 'Shipping Company Employee'
      $('#shipping_company').show()
    else if type == 'Agent/Supplier Employee'
      $('#agent').show()
