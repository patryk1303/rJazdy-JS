angular.module 'tTableApp'
  .controller 'BaseController', ['dataFilesService',(dataFilesService) ->
    vm = @
    getDataSuccess = (data) ->
      # assign data to globals!
      window.daytypes = data.daytypes
      window.departures = data.departures
      window.directions = data.directions
      window.lines = data.lines
      window.routes = data.routes
      window.signs = data.signs
      window.stops = data.stops
      return

    dataFilesService.getData().then(getDataSuccess)
  ]