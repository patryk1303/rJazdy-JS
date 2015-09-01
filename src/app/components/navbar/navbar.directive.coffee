angular.module "tTableApp"
  .directive 'acmeNavbar', ->

    directive =
      controller: ['$rootScope', ($rootScope) ->
        console.log $rootScope.page
      ],
      controllerAs: 'nav',
      restrict: 'E'
      templateUrl: 'app/components/navbar/navbar.html'
      bindToController: true
