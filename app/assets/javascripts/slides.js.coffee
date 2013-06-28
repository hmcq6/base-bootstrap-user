# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->

  ($ '.slide:gt(0)').hide()

  check_enabled = ->
    current_slide =  parseInt ($ '.slide:visible').attr('name')
                
    if !($ ".slide[name='#{current_slide + 1}']").length 
      ($ '#next_slide').addClass 'disabled'
    else
      ($ '#next_slide').removeClass 'disabled'
      
    if !($ ".slide[name='#{current_slide - 1}']").length 
      ($ '#previous_slide').addClass 'disabled'
    else
      ($ '#previous_slide').removeClass 'disabled'
          
  
  ($ '#next_slide').click ->
    if !($ @).hasClass('disabled')
  
      current_slide =  parseInt ($ '.slide:visible').attr('name')
    
      ($ ".slide[name='#{current_slide}']").hide()
      ($ ".slide[name='#{current_slide + 1}']").show()
    
      check_enabled()
    
  ($ '#previous_slide').click ->
    if !($ @).hasClass('disabled')
  
      current_slide =  parseInt ($ '.slide:visible').attr('name')
  
      ($ ".slide[name='#{current_slide}']").hide()
      ($ ".slide[name='#{current_slide - 1}']").show()
  
      check_enabled()
      
  set_order = (tab) ->
    ($ tab).find('tbody').find('tr').each (index) ->
      new_order = "<div class='text-center'><input type='text' id='post_slide' name='post[slide][#{index + 1}][order]' style='display:none;' value='#{index + 1}' />#{index + 1}</div>"
    
      ($ @).find('td').eq(0).html new_order
    
  add_row = (cur_row) ->
    row = ($ cur_row).closest 'tr'
    tbody = ($ row).closest 'tbody'
    table = ($ tbody).closest 'table'
    row_num = parseInt(($ row).index()) + 2

    ($ tbody).append '<tr class="target"></tr>'

    order = "<td><div class='text-center'><input type='text' id='post_slide' name='post[slide][#{row_num}][order]' style='display:none;' value='#{row_num}' />#{row_num}</div></td>"
    name = "<td><div class='text-center'><input type='text' id='post_slide' name='post[slide][#{row_num}][name]' class='input' /></div></td>"
    title = "<td><div class='text-center'><textarea id='post_slide' name='post[slide][#{row_num}][content]' class='input'></textarea></div></td>"
    timer = "<td><div class='text-center'><div class='input-prepend input-append'><input type='button' class='btn' value='+' /><input type='text' id='post_slide' name='post[slide][#{row_num}][timer]' class='input-mini text-center' /><input type='button' class='btn' value='-' /></div></div></td>"
    close = "<td><div class='text-center'><a class='btn'><i class='icon-remove'></i></a></div></td>"
    add = "<td><div class='text-center'><a class='btn'><i class='icon-plus'></i></a></div></td>"

    ($ '.target').append order
    ($ '.target').append name
    ($ '.target').append title
    ($ '.target').append timer
    ($ '.target').append close
    ($ '.target').append add
    
    ($ '.target td').eq(-1).click ->
      add_row(@)
      
    ($ '.target td').eq(-2).click ->
      if !($ @).hasClass 'disabled'
        remove_row(@)

    ($ '.target').removeClass 'target'

    set_order table
    
  remove_row = (cur_row) ->
    row = ($ cur_row).closest 'tr'
    table = ($ cur_row).closest 'table'
    
    ($ row).remove()
    
    set_order table
        
    if( ($ table).find('tbody').find('tr').length == 1 )
      ($ table).find('tr').children().eq(-2).find('a').addClass 'disabled'
    
  ($ 'div a').has('i.icon-plus').click ->
    add_row(@)
    ($ @).closest('tr').children().eq( ($ @).closest('td').index() - 1 ).find('a').removeClass 'disabled'

  ($ 'div a').has('i.icon-remove').click ->
    if !($ @).hasClass 'disabled'
      remove_row(@)
    