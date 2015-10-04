angular.module 'tTableApp'
  .directive 'loader', ->
    directive =
      restrict: 'E'
      replace: false
      templateUrl: 'app/components/loader/loader.html'
