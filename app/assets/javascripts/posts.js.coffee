# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  #console.log ($ '.editor').wysiwyg()

  ($ '#post_video').hide()
  ($ '#dummy').hide()
  ($ '#post_video').hide()
  ($ '#file_upload_button').hide()
  ($ '#slides').hide()

  ($ '#post_filter').change ->
    if( ($ '#post_filter').val() == 'videos' )
      ($ '#dummy').show()
      ($ '#slides').show()
      ($ '#file_upload_button').show()

  ($ '#file_upload_button').click ->
    ($ '#post_video').click()

  ($ '#post_video').change ->
    val = ($ this).val()

    file = val.split /[\\/]/

    ($ '#dummy').val file[file.length-1]