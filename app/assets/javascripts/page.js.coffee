class Pages.Page
  constructor: (page) ->
    @id          = page.id
    @name        = page.name
    @category    = page.category
    @accessToken = page.access_token
    @link        = null
    @posts       = []
    @additionalInfo()

  additionalInfo: =>
    FB.api "/#{@id}", (page) =>
      @link = page.link

  setup: =>
    @posts = []

    # Fetch posts
    FB.api "/#{@id}/promotable_posts", (response) =>

      _.each response.data, (post) =>
        @posts.push(new Pages.Post(post))

      # Render on page and setup events
      Pages.controller.show "page", @, =>
        @updatePosts()
        $("#new-post-button").on "click", =>
          Pages.newPost = new Pages.NewPost(@)
        $("#reload-button").on "click", =>
          @reload()
        $(document).on "fb:new-post", =>
          @reload()

  updatePosts: =>
    $(".post").on "click", ->
      $("#post-link-#{$(this).data("id")}").click()

    _.each @posts, (post) =>
      FB.api "/#{@id}_#{post.id}/insights/page_views", (response) ->
        $(".post[data-id=#{post.id}] .views .badge").html("#{response.data.length} views")

  reload: =>
    @posts = []
    FB.api "/#{@id}/promotable_posts", (response) =>
      _.each response.data, (post) =>
        @posts.push(new Pages.Post(post))
      Pages.controller.update $("#posts"), "posts", @, =>
        @updatePosts()

