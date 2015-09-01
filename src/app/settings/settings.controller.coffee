angular.module 'tTableApp'
  .controller 'SettingsController', ['$localStorage', 'toastr', '$rootScope', ($localStorage, toastr, $rootScope) ->
    $rootScope.page = 'Ustawienia'
    vm = @
    vm.minutesHold = if $localStorage.minutesHold isnt undefined then $localStorage.minutesHold else window.minutesHold
    vm.minutesHold = vm.minutesHold.toString()

    vm.save = ->
      tmpMinutesHold = parseInt vm.minutesHold,10
      $localStorage.minutesHold = tmpMinutesHold
      toastr.info 'Zapisano ustawienia'
      return

    return
  ]