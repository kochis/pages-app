class Pages.Page
  constructor: (page) ->
    @id          = page.id
    @name        = page.name
    @category    = page.category
    @accessToken = page.access_token
    @link        = null
    @posts       = []

  setup: =>
    @posts = []

    # Get additional page info
    FB.api "/#{@id}", (page) =>
      @link = page.link
      Pages.controller.show("page", @)

    # Get posts
    FB.api "/#{@id}/promotable_posts", (response) =>
      _.each response.data, (post) =>
        @posts.push(new Pages.Post(post))
      Pages.controller.show("page", @)
      $(document).trigger("pages:posts-loaded")
      @updateViewCounts()

  updateViewCounts: =>
    _.each @posts, (post) =>
      FB.api "/#{@id}_#{post.id}/insights/page_views", (response) ->
        $(".post[data-id=#{post.id}] .views .badge").html("#{response.data.length} views")

  reload: =>
    @setup()

