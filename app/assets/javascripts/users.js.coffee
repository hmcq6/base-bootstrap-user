$ ->
  ($ '#create_user').dialog({ 
    modal: true,
    minWidth: 400,
    })
    
  ($ '#user_nav a').click (e) ->
    e.preventDefault()
    ($ @).tab 'show'
