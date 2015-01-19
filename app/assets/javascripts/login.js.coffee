class Pages.Login
  constructor: ->
    FB.getLoginStatus (response) =>
      if response.status == "connected"
        @loggedIn()
      else
        @loginButton = $(".fb-button")
        @loginButton.fadeIn("fast").on "click", @login

  login: =>
    FB.login((response) =>
      if response.status == "connected"
        @loginButton.fadeOut("fast")
        @loggedIn()
    ,{scope: 'public_profile,email,manage_pages,read_page_mailboxes'})

  loggedIn: ->
    $('#login').hide()
    $(document).trigger("fb:logged-in")

$ ->
  $(document).on "fb:loaded", () ->
    new Pages.Login
