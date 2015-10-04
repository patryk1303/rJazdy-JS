angular.module 'tTableApp'
  .controller 'StopsController', ['$rootScope','$localStorage', ($rootScope,$localStorage) ->
    $rootScope.page = 'Przystanki'
    vm = @
    vm.stops = stops
    vm.search = ''
    vm.itemOnLongPress = (stop) ->
      currentStopInFavs = no
      favStops = $localStorage.favs.seek (el) ->
        return el.type is 'stops'
      favStops.each (el) ->
        if `el.content == stop.id`
          currentStopInFavs = yes
      if not currentStopInFavs
        favObj = 
          type: 'stops'
          content: stop.id
        $localStorage.favs.push favObj
        toastr.info 'Dodano przystanek ' + stop.name1 + ' ' + stop.name2 + ' do ulubionych'
        return
      else
        toastr.info 'Przystanek jest już w ulubionych'
        return
    return
  ]