# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#user_shipping_company_id').parent().hide()
  $('#user_agent_id').parent().hide()
  $('#user_type').change ->
    type = $('#user_type :selected').text()
    if type == 'Shipping Company employee'
      $('#user_agent_id').parent().hide()
      $('#user_agent_id').empty()
      $('#user_shipping_company_id').parent().show()
    else if type == 'Agent/Supplier employee'
      $('#user_shipping_company_id').parent().hide()
      $('#user_shipping_company_id').empty()
      $('#user_agent_id').parent().show()
