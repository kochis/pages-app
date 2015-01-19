class Pages.List
  constructor: ->
    @pages = []
    @currentPage = null

    # Events
    $(document).on "fb:logged-in", @setup

  setup: =>
    FB.api "me/accounts", (response) =>
      _.each response.data, (page) =>
        @pages.push(page) if _.contains(page.perms, "ADMINISTER")
      Pages.controller.show("page-select", {pages: @pages})

$ ->
  Pages.list = Pages.list || new Pages.List
