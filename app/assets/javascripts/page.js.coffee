class Pages.Page
  constructor: (page) ->
    @id          = page.id
    @name        = page.name
    @category    = page.category
    @accessToken = page.access_token

    @link  = null
    @likes = null
    @views = null
    @posts = []

  setup: =>
    # Get additional page info
    FB.api "/#{@id}", (page) =>
      @link = page.link
      @likes = page.likes
      @views = page.were_here_count
      Pages.controller.show("page", @)

    # Get posts
    FB.api "/#{@id}/promotable_posts", (response) =>
      _.each response.data, (post) =>
        @posts.push(new Pages.Post(post))
      Pages.controller.show("page", @)
      @updateViews()

  updateViews: =>
    _.each @posts, (post) =>
      FB.api "/#{@id}_#{post.id}/insights/page_views", (response) ->
        $(".post[data-id=#{post.id}] .views .badge").html("#{response.data.length} views")

