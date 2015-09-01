angular.module 'tTableApp'
  .controller 'FavsController', ['$localStorage', '$rootScope', ($localStorage,$rootScope) ->
    $rootScope.page = 'Ulubione'
    vm = @
    vm.favs = $localStorage.favs
    console.log vm.favs
    return
  ]