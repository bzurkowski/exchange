$(document).ready ->
  $("input.datetime_picker").datetimepicker
    format: "Y-m-d H:i"
    step: 5
    dayOfWeekStart: 1
    minTime: "8:00"
    maxTime: "22:00"
