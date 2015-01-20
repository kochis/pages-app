class Pages.Controller
  constructor: ->
    @container = $("#display-container")
    @currentPage = null
    @templates = {
      "login":       Handlebars.compile($('#login-template').html()),
      "page-select": Handlebars.compile($('#page-select-template').html()),
      "page":        Handlebars.compile($('#page-template').html())
    }

    # Routes
    $(document).on "fb:loaded", Pages.login.setup
    $(document).on "fb:logged-in", Pages.pageList.setup

    $(document).on "pages:page-selected", (event, id) =>
      @currentPage = Pages.pageList.selected(id)

    $(document).on "pages:posts-loaded", =>
      $("#new-post-button").on "click", =>
        Pages.newPost = new Pages.NewPost(@currentPage)
      $("#reload-button").on "click", =>
        @currentPage.reload()

    $(document).on "fb:new-post", =>
      Pages.newPost.close()
      @currentPage.reload()


  show: (template, context) =>
    @container.html(@templates[template](context))
    $(document).trigger("pages:show")

$ ->
  Pages.controller = Pages.controller || new Pages.Controller
