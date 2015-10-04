angular.module 'tTableApp'
  .controller 'LinesController', ['$rootScope','toastr','$localStorage', ($rootScope, toastr, $localStorage) ->
    $rootScope.page = 'Linie'
    vm = @
    vm.lines = lines.sort (a,b) ->
      a.line - b.line
    vm.itemOnLongPress = (line) ->
      currentLinesInFavs = no
      favLines = $localStorage.favs.seek (el) ->
        return el.type is 'lines'
      favLines.each (el) ->
        if `el.content == line.line`
          currentLinesInFavs = yes
      if not currentLinesInFavs
        favObj = 
          type: 'lines'
          content: line.line
        $localStorage.favs.push favObj
        toastr.info 'Dodano linię ' + line.line + ' do ulubionych'
        return
      else
        toastr.info 'Linia już jest w ulubionych'
        return
    return
  ]