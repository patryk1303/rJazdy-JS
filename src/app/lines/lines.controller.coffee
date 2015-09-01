angular.module 'tTableApp'
  .controller 'LinesController', ['$rootScope', ($rootScope) ->
    $rootScope.page = 'Linie'
    vm = @
    vm.lines = lines.sort (a,b) ->
      a.line - b.line
    return
  ]