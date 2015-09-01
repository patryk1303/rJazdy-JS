# departures functions

window.getDeparturesHours = (line,dirNo,stop) ->
  out = []
  deps = departures.seek (el) ->
    `el.stopid == stop` and
    `el.dirnumber == dirNo` and
    `el.line == line`
  deps.each (el) ->
    out.push el.hour

  out.unique()

window.getDeparturesforHour = (line,dirNo,stop,hour,daytype) ->
  departures.seek (el) ->
    `el.daytype == daytype` and
    `el.stopid == stop` and
    `el.dirnumber == dirNo` and
    `el.line == line` and
    `el.hour == hour`

window.getDepartures = (line,dirNo,stop,daytype) ->
  departures.seek (el) ->
    `el.daytype == daytype` and
    `el.stopid == stop` and
    `el.dirnumber == dirNo` and
    `el.line == line`

# stops functions

window.getLinesFromStop = (stop) ->
  routes.seek (el) ->
    `el.stopid == stop`

window.getChronoDepartures = (stop,daytype) ->
  out = []
  chrono = departures.seek (el) ->
    `el.stopid == stop` and
    `el.daytype == daytype`

  chrono.each (el) ->
    el.direction = getDirectionName(el.line,el.dirnumber)

  chrono.sort (a,b) ->
    new Date('1970/01/01 ' + a.hour + ':' + a.min) -
    new Date('1970/01/01 ' + b.hour + ':' + b.min)

window.getStopName = (stop) ->
  stops.seek((el) ->
    `el.id == stop`
  )[0]

window.getOtherLines = (stop) ->
  out = []
  tmpOut = []
  tmp = departures.seek (el) ->
    `el.stopid == stop`
  tmp.each (el) ->
    tmpOut.push
      line: el.line
      dirNo: el.dirnumber
      dirName: getDirectionName(el.line,el.dirnumber)
  tmpOut
  # todo - unique!

# directions functions

window.getLineDirections = (line) ->
  directions.seek (el) ->
    `el.line == line`

window.getRoute = (line,dirNo) ->
  route = routes.seek (el) ->
    `el.line == line` and
    `el.dirnumber == dirNo`

  route.each (el) ->
    el.stop_name = getStopName(el.stopid)

  route

window.getDirectionName = (line,dirNo) ->
  directions.seek((el) ->
    `el.line == line` and
    `el.dirnumber == dirNo`
  )[0].name.trim()


window.getTrip = (line,dirNo,daytype,tripNo) ->
  trip = departures.seek (el) ->
    `el.line == line` and
    `el.dirnumber == dirNo` and
    `el.daytype == daytype` and
    `el.tripnumber == tripNo`
  trip.each (el) ->
    el.stop_name = getStopName(el.stopid)

  trip

# lines
window.getLines = () ->
  lines

# signs
window.getLineSigns = (line,dirNo) ->
  signs.seek (el) ->
    `el.line == line` and
    `el.dirnumber == dirNo`

window.getSigns = (line,dirNo,stop) ->
  currentSigns = []
  currentStopSigns = []
  lineStopSigns = []
  # get all signs for line direction
  lineSigns = getLineSigns line,dirNo
  # get all signs for current stop for line direction
  lineStopSignsTmp = departures.seek (el) ->
    `el.stopid == stop` and
    `el.dirnumber == dirNo` and
    `el.line == line`
  lineStopSignsTmp.each (el) ->
    lineStopSigns.push el.signs
  lineStopSigns = lineStopSigns.unique()

  # split all signs
  lineStopSigns.each (el) ->
    el.split('').each (sign) ->
      if sign != '' then currentStopSigns.push sign
      return
    return
  # remove duplicated signs
  currentStopSigns = currentStopSigns.unique()

  # return only signs used in current stop
  lineSigns.seek (el) ->
    currentStopSigns.indexOf(el.sign) >= 0