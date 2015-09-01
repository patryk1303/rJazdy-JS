angular.module 'tTableApp'
  .controller 'StopController', ['$routeParams','$localStorage','moment','$rootScope', ($routeParams,$localStorage,moment,$rootScope) ->
    vm = @
    vm.stop = $routeParams.stop
    vm.departures = []
    vm.daytypes = daytypes
    vm.minutesHold = if $localStorage.minutesHold isnt undefined then $localStorage.minutesHold else window.minutesHold
    vm.minutesHold = parseInt vm.minutesHold,10
    vm.stopName = getStopName(vm.stop)
    vm.weekDay = weekDay
    vm.openGroups = []

    $rootScope.page = vm.stopName.name1
    if vm.stopName.name2
      $rootScope.page += ' / ' + vm.stopName.name2

    tmpDate = new Date()
    tmpCurrentHour = tmpDate.getHours()
    tmpCurrentMinute = (tmpDate.getMinutes()-vm.minutesHold)

    if tmpCurrentMinute < 0
      tmpCurrentMinute = 60 + tmpCurrentMinute
      tmpCurrentHour -= 1

    currentTime = tmpCurrentHour + ':' + (tmpCurrentMinute)

    daytypes.each (el) ->
      if vm.weekDay.between 1,5 # Monday - Friday
        if `el.id == 1` then vm.openGroups.push yes else vm.openGroups.push no
      else if vm.weekDay is 6 # Saturday
        if `el.id == 2` then vm.openGroups.push yes else vm.openGroups.push no
      else # Sunday
        if `el.id == 3` then vm.openGroups.push yes else vm.openGroups.push no
      deps = getChronoDepartures(vm.stop,el.id)
      deps = deps.seek (el) ->
        timeTmp = el.hour + ':' + el.min
        checkTimes(timeTmp,currentTime, '23:59')
      vm.departures.push deps

    return
  ]