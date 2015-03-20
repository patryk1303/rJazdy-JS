var daytypes,departures,directions,lines,routes,signs,stops = null;
var DAYS = ["Dni powszednie","Soboty","Niedziele i święta"];

angular.module('starter', ['ionic', 'starter.controllers','starter.directives','starter.services','starter.filters'])

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }
  });
})

.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider

  .state('app', {
    url: "/app",
    abstract: true,
    templateUrl: "templates/menu.html",
    controller: 'AppCtrl',
    resolve: {
      load: function(DataService) {
        return DataService.getData();
      }
    }
  })

  .state('app.main', {
    url: "/",
    views: {
      'menuContent': {
        templateUrl: "templates/main_menu.html"
      }
    }
  })

  .state('app.lines', {
    url: "/lines",
    views: {
      'menuContent': {
        templateUrl: "templates/lines.html",
        controller: "LinesCtrl"
      }
    }
  })

  .state('app.directions', {
    url: "/line/:line",
    views: {
      'menuContent': {
        templateUrl: "templates/directions.html",
        controller: "DirectionsCtrl"
      }
    }
  })

  .state('app.departures', {
    url: "/line/:line/:dir_no/:stop_id",
    views: {
      'menuContent': {
        templateUrl: "templates/departures.html",
        controller: "DeparturesCtrl"
      }
    }
  })

  .state('app.trip', {
    url: "/trip/:line/:dir_no/:stop_id/:trip_no/:day_id",
    views: {
      'menuContent': {
        templateUrl: "templates/trip.html",
        controller: "TripCtrl"
      }
    }
  })

  .state('app.stops', {
    url: "/stops",
    views: {
      'menuContent': {
        templateUrl: "templates/stops.html",
        controller: "StopsCtrl"
      }
    }
  })

  .state('app.stop', {
    url: "/stop/:stop_id",
    views: {
      'menuContent': {
        templateUrl: "templates/stop.html",
        controller: "StopCtrl"
      }
    }
  })

  .state('app.help', {
    url: "/help",
    views: {
      'menuContent': {
        templateUrl: "templates/help.html",
      }
    }
  });
  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/app/');
});
