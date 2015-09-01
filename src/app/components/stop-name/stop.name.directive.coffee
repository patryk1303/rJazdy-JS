angular.module 'tTableApp'
  .directive 'stopName', ->
    directive =
      restrict: 'E'
      replace: false
      scope: stop: '=data', bull: '=bull'
      templateUrl: 'app/components/stop-name/stop.name.html'