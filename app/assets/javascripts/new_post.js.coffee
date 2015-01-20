class Pages.NewPost
  constructor: (page) ->
    @page = page
    @container = $("#new-post").show()
    @form = $("#new-post-form")
    @scheduledDate = null
    @scheduledTime = null
    @setupDatePicker()

    @form.on "submit", @handleSubmit

  close: =>
    @container.hide()
    @scheduledDate = null
    @scheduledTime = null
    @form.find("[name=message]").val("")
    @form.on "submit", null

  handleSubmit: (event) =>
    event.preventDefault()
    FB.api(
      "#{@page.id}/feed",
      "post",
      @data(),
      (response) =>
        if (response.error)
          @form.find('.error-message').html(response.error.message)
        else
          $(document).trigger("fb:new-post")
    )

  data: =>
    params = {
      message: @form.find("[name=message]").val(),
      access_token: @page.accessToken
    }

    if @scheduledDate
      params = _.extend(params, {
        scheduled_publish_time: (new Date(@scheduledDate + (@scheduledTime * 1000 * 60)).getTime() / 1000),
        published: false
      })

    params

  setupDatePicker: =>
    @form.find('#schedule-post-date').pickadate(
      min: new Date(new Date().getTime() + 24 * 60 * 60 * 1000),
      format: 'm/d/yyyy',
      onSet: (context) =>
        @scheduledDate = context.select
        $('#schedule-post-time').show().pickatime(
          interval: 10,
          onSet: (context) =>
            @scheduledTime = context.select
        )
    )

