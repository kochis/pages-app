class Pages.Login
  constructor: ->
    # do nothing

  setup: =>
    FB.getLoginStatus (response) =>
      if response.status == "connected"
        @loggedIn()
      else
        Pages.controller.show "login", null, =>
          $(".fb-button").on "click", @login

  login: =>
    FB.login((response) =>
      if response.status == "connected"
        @loggedIn()
    ,{scope: 'public_profile,email,manage_pages,read_page_mailboxes,publish_actions'})

  loggedIn: ->
    $(document).trigger("fb:logged-in")
