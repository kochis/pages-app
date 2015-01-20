$ ->
  $(document).on "pages:show" , ->
    $('[data-toggle="tooltip"]').tooltip()
    $('#schedule-post-date').pickadate(
      min: new Date(new Date().getTime() + 24 * 60 * 60 * 1000),
      format: 'm/d/yyyy',
      onSet: () ->
        $('#schedule-post-time').show().pickatime()
    )
