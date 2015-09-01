angular.module "tTableApp"
  .config ['$routeProvider',($routeProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "app/main/main.html"
        controller: "MainController"
        controllerAs: "main"
        resolve:
          load: loadData
      .when '/lines',
        templateUrl: 'app/lines/lines.html'
        controller: 'LinesController'
        controllerAs: 'lines'
        resolve:
          load: loadData
      .when '/lines/:line',
        templateUrl: 'app/directions/directions.html'
        controller: 'DirectionsController'
        controllerAs: 'directions'
        resolve:
          load: loadData
      .when '/departures/:line/:dirNo/:stop',
        templateUrl: 'app/departures/departures.html'
        controller: 'DeparturesController'
        controllerAs: 'departures'
        resolve:
          load: loadData
      .when '/trip/:line/:dirNo/:stop/:daytype/:tripNo',
        templateUrl: 'app/trip/trip.html'
        controller: 'TripController'
        controllerAs: 'trip'
        resolve:
          load: loadData
      .when '/stops',
        templateUrl: 'app/stops/stops.html'
        controller: 'StopsController'
        controllerAs: 'stops'
        resolve:
          load: loadData
      .when '/stops/:stop',
        templateUrl: 'app/stop/stop.html'
        controller: 'StopController'
        controllerAs: 'stop'
        resolve:
          load: loadData
      .when '/settings',
        templateUrl: 'app/settings/settings.html'
        controller: 'SettingsController'
        controllerAs: 'settings'
        resolve:
          load: loadData
      .when '/favs',
        templateUrl: 'app/favs/favs.html'
        controller: 'FavsController'
        controllerAs: 'favs'
        resolve:
          load: loadData
      .otherwise
        redirectTo: "/"
  ]

loadData = ['dataFilesService',(dataFilesService) ->
  dataFilesService.getData()
]