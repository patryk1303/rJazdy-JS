angular.module 'tTableApp'
  .controller 'TripController', ['$routeParams','$rootScope',($routeParams,$rootScope) ->
    $rootScope.page = 'Przebieg'
    vm = @
    vm.stop = $routeParams.stop
    vm.line = $routeParams.line
    vm.dirNo = $routeParams.dirNo
    vm.daytype = $routeParams.daytype
    vm.tripNo = $routeParams.tripNo

    # line,dirNo,daytype,tripNo
    vm.trip = getTrip(vm.line,vm.dirNo,vm.daytype,vm.tripNo)

    return
  ]