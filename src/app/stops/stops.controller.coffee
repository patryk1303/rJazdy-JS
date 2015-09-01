angular.module 'tTableApp'
  .controller 'StopsController', ['$rootScope', ($rootScope) ->
    $rootScope.page = 'Przystanki'
    vm = @
    vm.stops = stops
    vm.search = ''
    return
  ]