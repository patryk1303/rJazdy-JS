angular.module 'tTableApp'
  .controller 'DirectionsController', ['$routeParams','$rootScope','$localStorage', ($routeParams,$rootScope,$localStorage) ->
    $rootScope.page = 'Linia ' + $routeParams.line
    vm = @
    vm.line = $routeParams.line
    vm.directions = getLineDirections(vm.line)
    vm.directions.each (el) ->
      el.route = getRoute(vm.line,el.dirnumber)
    vm.itemOnLongPress = (stop) ->
      console.log stop
      dirName = getDirectionName stop.line,stop.dirnumber
      favObj = 
        type: 'departures'
        content: "#{stop.line}/#{stop.dirnumber}/#{stop.stopid}"
        body: "<i class=\"fa fa-bus\"></i> #{stop.line} <i class=\"fa fa-arrow-circle-right\"></i> #{dirName} <i class=\"fa fa-spoon\"></i> #{stop.stop_name.name1} #{stop.stop_name.name2}"
      $localStorage.favs.push favObj
      toastr.info 'Dodano element do ulubionych'
      return
    return
  ]