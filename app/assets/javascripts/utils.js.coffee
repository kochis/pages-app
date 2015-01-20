$ ->
  window.localTime = (date) ->
    hours = date.getHours()
    amPm = "am"
    if hours >= 12
      amPm = "pm"
      if hours > 12
        hours = hours - 12
    minutes = date.getMinutes()
    if minutes < 10
      minutes = "0" + minutes
    "#{hours}:#{minutes} #{amPm}"
