class Pages.Manager
  constructor: ->
    @template = Handlebars.compile($('#page-list-template').html())
    @pages = []
    @currentPage

    @showPageList()

  showPageList: =>
    FB.api "me/accounts", (response) =>
      _.each response.data, (page) =>
        @pages.push(page) if _.contains(page.perms, "ADMINISTER")
      $('#page-select').html(@template(pages: @pages))

$ ->
  $(document).on "fb:logged-in", () ->
    Pages.app = Pages.app || new Pages.Manager
