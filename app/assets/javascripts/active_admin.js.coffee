#= require active_admin/base
#= require activeadmin_addons/all
#= require active_material

#= require Chart.bundle
#= require chartkick

#$(document).ready () -> alert "Javascript y Jquery estan cargados."
# $(document).ready(function(){
#           #capturamos el vento onchange dentro del selecctor ID
#           $("select#center_address_attributes_country_id").change(function(){
#                 #Send the request and update provinces dropdown
#                 $.ajax({
#                       dataType: "json",
#                       cache: false,
#                       #Hacemos la llamada a nuestro controlador en admin
#                       url: 'mi ruta correspondiente/change_provinces?country_id=' + $('#center_address_attributes_country_id :selected').val(),
#                       timeout: 2000,
#                       error: function(XMLHttpRequest, errorTextStatus, error){
#                                alert("Failed to submit : "+ errorTextStatus+" ;"+error);
#                                },
#                       success: function(data){
#                                 #Clear all options from provinces and cities select
#                                 #Eliminamos los datos que tenga
#                                 $("select#center_address_attributes_province_id option").remove();
#                                 #Eliminamos los datos que tenga
#                                 $("select#center_address_attributes_city_id option").remove();
#                                 var row;
#                                 #por si queremos meter un elemento primero vacío
#                                 $(row).appendTo("select#center_address_attributes_province_id");
#                                 #New provinces select
#                                 $.each(data, function(i, j){
#                                           row = "<option value=\"" + j.id + "\">" + j.name + "</option>";
#                                           #Vamos incorporando los nuevos
#                                           $(row).appendTo("select#center_address_attributes_province_id");
#                                          });
#                                 }
#                 });
#             });
# });

# $(document).ready ->
#   $('select#employee_area_id').change ->
#     alert 'change_command_list?area_id=' + $('#employee_area_id').val()
#     $.ajax
#       dataType: 'json'
#       cache: false
#       url: '/admin/employees/change_command_list?area_id=' + $('#employee_area_id').val()
#       timeout: 2000
#       error: (XMLHttpRequest, errorTextStatus, error) ->
#         alert 'Failed to submit : ' + errorTextStatus + ' ;' + error
#         return
#       success: (data) ->
#         console.log data
#         console.log $('input#employee_command_list_ids').attr('data-collection')
#         $('input#employee_command_list_ids').attr('data-collection','[{"id":1,"text":"ConfIng"}]')
#         #$('input#employee_command_list_ids').remove()
#         #$('select#employee_area_id option').remove()
#         row = undefined
#         # $(row).appendTo 'select#employee_command_list_ids'
#         $.each data, (i, j) ->
#           row = '<option value="' + j.id + '">' + j.name + '</option>'
#           console.log row
#           $(row).appendTo 'select#employee_command_list_ids'
#           return
#         return
#     return
#   return
$(document).on 'ready page:load', ->
  if $('#command_list_all_commands').prop('checked')
    $('#command_list_command_ids_input').hide()
    $('#command_list_exclude_command_ids_input').show()
  else
    $('#command_list_command_ids_input').show()
    $('#command_list_exclude_command_ids_input').hide()

  $('input#command_list_all_commands').change ->
    if @checked
      $('#command_list_command_ids_input').hide()
      $('#command_list_exclude_command_ids_input').show()
    else
      $('#command_list_command_ids_input').show()
      $('#command_list_exclude_command_ids_input').hide()
    return

  $('#connectivity').click ->
    $('#network_element_table tbody tr').each ->
      $(this).find("td:first").html('Cargando')
      $(this).find("td:last").html('Cargando')
      $.get(window.location.href+'/connectivity')
      return
return
