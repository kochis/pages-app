class Pages.List
  constructor: ->
    @pages = []
    @currentPage = null

  setup: =>
    FB.api "me/accounts", (response) =>
      _.each response.data, (page) =>
        @pages.push(new Pages.Page(page)) if _.contains(page.perms, "ADMINISTER")
      Pages.controller.show("page-select", {pages: @pages})
