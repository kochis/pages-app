class Pages.Post
  constructor: (post) ->
    @id = post.id
    @created = new Date(post.created_time)
    @message = post.message
    @isPublished = post.is_published

  published: =>
    if @isPublished then "published" else "unpublished"

  publishDate: =>
    dateString = "Publish"
    dateString += "ed" if @isPublished
    dateString + " on #{@created.toDateString()} at #{localTime(@created)}"
