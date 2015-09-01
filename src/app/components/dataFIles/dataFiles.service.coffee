angular.module 'tTableApp'
  .factory 'dataFilesService', ['$log','$http','$q',($log, $http, $q) ->
    getData = ->
      getDataComplete = (response) ->
        d = response
        data.daytypes = d[0].data
        data.departures = d[1].data
        data.directions = d[2].data
        data.lines = d[3].data
        data.routes = d[4].data
        data.signs = d[5].data
        data.stops = d[6].data
        delay.resolve data

      getDataError = (error) ->
        $log.error 'XHR Failed.\n' + angular.toJson(error.data, true)
        delay.reject error

      delay = $q.defer()
      data = {}

      sDaytypes = $http.get 'assets/timetable/daytypes.json', cache: yes
      sDepartures = $http.get 'assets/timetable/departures.json', cache: yes
      sDirections = $http.get 'assets/timetable/directions.json', cache: yes
      sLines = $http.get 'assets/timetable/lines.json', cache: yes
      sRoutes = $http.get 'assets/timetable/routes.json', cache: yes
      sSigns = $http.get 'assets/timetable/signs.json', cache: yes
      sStops = $http.get 'assets/timetable/stops.json', cache: yes

      arrQ = [sDaytypes,sDepartures,sDirections,sLines,sRoutes,sSigns,sStops]

      $q.all(arrQ).then(getDataComplete).catch getDataError

      delay.promise

    service =
      getData: getData
  ]