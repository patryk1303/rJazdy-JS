angular.module 'tTableApp'
  .directive 'stopNameById', ->
    directive =
      controller: ($scope) ->
        $scope.stop = getStopName($scope.id)
      restrict: 'E'
      replace: false
      scope: id: '=id', stop: '=stop', bull: '=bull'
      templateUrl: 'app/components/stop-name-by-id/stop.name.by.id.html'