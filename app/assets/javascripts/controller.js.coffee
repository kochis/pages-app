class Pages.Controller
  constructor: ->
    @container = $("#display-container")
    @currentPage = null
    @templates = {
      "login":       Handlebars.compile($('#login-template').html()),
      "page-select": Handlebars.compile($('#page-select-template').html()),
      "page":        Handlebars.compile($('#page-template').html())
    }

    # Events
    $(document).on "fb:loaded", Pages.login.setup
    $(document).on "fb:logged-in", Pages.pageList.setup
    $(document).on "pages:page-selected", (event, id) ->
      Pages.pageList.selected(id)

  show: (template, context) =>
    @container.html(@templates[template](context))
    @currentPage = template
    $(document).trigger("pages:show")

$ ->
  Pages.controller = Pages.controller || new Pages.Controller
