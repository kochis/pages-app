class Pages.Login
  constructor: ->
    FB.getLoginStatus (response) =>
      if response.status == "connected"
        @loggedIn()
      else
        Pages.controller.show("login")
        $(".fb-button").on "click", @login

  login: =>
    FB.login((response) =>
      if response.status == "connected"
        @loggedIn()
    ,{scope: 'public_profile,email,manage_pages,read_page_mailboxes'})

  loggedIn: ->
    $(document).trigger("fb:logged-in")

$ ->
  $(document).on "fb:loaded", () ->
    new Pages.Login
