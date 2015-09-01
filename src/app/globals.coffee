window.daytypes = null
window.stops = null
window.lines = null
window.directions = null
window.routes = null
window.signs = null
window.departures = null
window.weekDay = new Date().getDay()

# todo - move this variable to cookies!
window.minutesHold = 10


# cheks if timeToCompare is between startTime and endTime
window.checkTimes = (timeToCompare, startTime, endTime) ->  
  tmp = timeToCompare + ' ' + startTime + ' ' + endTime
  # console.log tmp
  time = new Date()
  currentDate = (time.getMonth()+1) + '/' + time.getDate() + '/' + time.getFullYear() + ' '
  timeToCompare_test = currentDate + timeToCompare
  startTime_test = currentDate + startTime
  endTime_test = currentDate + endTime
  timeToCompare_MS = new Date(timeToCompare_test).getTime()
  startTime_MS = new Date(startTime_test).getTime()
  endTime_MS = new Date(endTime_test).getTime()
  timeToCompare_MS >= startTime_MS and timeToCompare_MS < endTime_MS

window.between = (val, start, end) ->
  val >= start and val <= end