class Pages.PageList
  constructor: ->
    @pages = []
    @currentPage = null

  setup: =>
    FB.api "me/accounts", (response) =>

      # Parse fb response
      _.each response.data, (page) =>
        @pages.push(new Pages.Page(page)) if _.contains(page.perms, "ADMINISTER")

      # Render on page
      Pages.controller.show("page-select", {pages: @pages})

      # Setup event handler
      $("#page-list .page").on "click", ->
        $(document).trigger("pages:page-selected", "#{$(this).data("id")}")

  selected: (id) =>
    @currentPage = _.find @pages, (page) ->
      page.id == id
    @currentPage.setup()
    @currentPage
