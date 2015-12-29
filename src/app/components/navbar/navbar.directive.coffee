angular.module "tTableApp"
  .directive 'acmeNavbar', ->

    directive =
      controller: ['$scope', '$rootScope', ($scope, $rootScope) ->
        console.log $rootScope.page
        $scope.back = ->
          window.history.back()
#          
      ],
      controllerAs: 'nav',
      restrict: 'E'
      templateUrl: 'app/components/navbar/navbar.html'
      bindToController: true
