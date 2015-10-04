angular.module 'tTableApp'
  .controller 'FavsController', ['$localStorage', '$rootScope', ($localStorage,$rootScope) ->
    $rootScope.page = 'Ulubione'
    vm = @
    vm.favs = $localStorage.favs
    vm.removeItem = (index) ->
      $localStorage.favs.splice(index,1)
      vm.favs = $localStorage.favs
      toastr.info 'Usunięto element z ulubionych'
      return
    return
  ]