# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#user_shipping_company_id').parent().hide()
  $('#user_agent_id').parent().hide()
  $('#user_type').change ->
    type = $('#user_type :selected').text()
    if type == 'Shipping Company Employee'
      $('#agent').hide()
      $("#user_agent_id")[0].options[0].selected = true;
      $('#shipping_company').show()
    else if type == 'Agent/Supplier Employee'
      $('#shipping_company').hide()
      $("#user_shipping_company_id")[0].options[0].selected = true;
      $('#agent').show()
