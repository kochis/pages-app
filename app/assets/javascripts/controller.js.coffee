class Pages.Controller
  constructor: ->
    @container = $("#display-container")
    @currentPage = null
    @templates = {
      "login":       Handlebars.compile($('#login-template').html()),
      "page-select": Handlebars.compile($('#page-select-template').html()),
      "page":        Handlebars.compile($('#page-template').html())
    }

    # Partials
    Handlebars.registerPartial("posts", $("#posts-partial").html())

    # Routes
    $(document).on "fb:logged-in", Pages.pageList.setup
    $(document).on "pages:page-selected", (event, id) =>
      @currentPage = Pages.pageList.selected(id)


  show: (template, context, callback) =>
    @container.fadeOut "fast", () =>
      @container.html(@templates[template](context))
      @container.fadeIn "fast", () ->
        $(document).trigger("pages:show")
        callback() if callback

  update: (target, partial, context, callback) =>
    target.fadeOut "fast", () =>
      target.html(Handlebars.partials[partial](context))
      target.fadeIn "fast", () ->
        $(document).trigger("pages:update")
        callback() if callback

$ ->
  Pages.controller = Pages.controller || new Pages.Controller
