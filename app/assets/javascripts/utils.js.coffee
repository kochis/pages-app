$ ->
  window.localTime = (date) ->
    hours = date.getHours()
    amPm = "am"
    if hours >= 12
      amPm = "pm"
      if hours > 12
        hours = hours - 12
    "#{hours}:#{date.getMinutes()}#{amPm}"
