class Pages.Login
  constructor: ->
    # do nothing

  setup: =>
    FB.getLoginStatus (response) =>
      if response.status == "connected"
        @loggedIn()
      else
        $(".fb-button").on "click", @login
        Pages.controller.show("login")

  login: =>
    FB.login((response) =>
      if response.status == "connected"
        @loggedIn()
    ,{scope: 'public_profile,email,manage_pages,read_page_mailboxes'})

  loggedIn: ->
    $(document).trigger("fb:logged-in")
