angular.module 'tTableApp'
  .controller 'DirectionsController', ['$routeParams','$rootScope', ($routeParams,$rootScope) ->
    $rootScope.page = 'Linia ' + $routeParams.line
    vm = @
    vm.line = $routeParams.line
    vm.directions = getLineDirections(vm.line)
    vm.directions.each (el) ->
      el.route = getRoute(vm.line,el.dirnumber)
    return
  ]