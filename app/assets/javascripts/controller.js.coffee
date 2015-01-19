class Pages.Controller
  constructor: ->
    @container = $("#display-container")
    @currentPage = null
    @templates = {
      "login":       Handlebars.compile($('#login-template').html()),
      "page-select": Handlebars.compile($('#page-select-template').html())
    }

  show: (template, context) =>
    @container.html(@templates[template](context))
    @currentPage = template

$ ->
  Pages.controller = Pages.controller || new Pages.Controller
