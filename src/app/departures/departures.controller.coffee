angular.module 'tTableApp'
  .controller 'DeparturesController', ['$routeParams','$rootScope','$modal', ($routeParams,$rootScope,$modal) ->
    $rootScope.page = 'Odjazdy - linia ' + $routeParams.line
    vm = @
    vm.line = $routeParams.line
    vm.dirNo = $routeParams.dirNo
    vm.stop = $routeParams.stop
    vm.hours = getDeparturesHours(vm.line,vm.dirNo,vm.stop)
    vm.departures = []
    vm.daytypes = daytypes
    vm.directionName = getDirectionName vm.line,vm.dirNo
    vm.stopName = getStopName vm.stop
    vm.signs = getSigns vm.line,vm.dirNo,vm.stop
    vm.weekDay = weekDay
    vm.deps_counts = []
    vm.openGroups = []

    vm.otherLines = ->
      $modal.open
        templateUrl: 'app/departures/other_lines_modal.html'
        animation: no

    daytypes.each (daytype) ->
      if vm.weekDay.between 1,5 # Monday - Friday
        if `daytype.id == 1` then vm.openGroups.push yes else vm.openGroups.push no
      else if vm.weekDay is 6 # Saturday
        if `daytype.id == 2` then vm.openGroups.push yes else vm.openGroups.push no
      else # Sunday
        if `daytype.id == 3` then vm.openGroups.push yes else vm.openGroups.push no
      tmp = []
      deps_count = 0
      vm.hours.each (hour) ->
        tmp.push
          hour: hour
          deps_hour: getDeparturesforHour vm.line,vm.dirNo,vm.stop,hour,daytype.id
        return
      tmp.each (el)  ->
        deps_count += el.deps_hour.length
      vm.departures.push tmp
      vm.deps_counts.push deps_count
      return

    return
  ]