angular.module('starter.controllers', [])

.controller('GlobalCtrl', function($rootScope,DataService) {
  $rootScope.getTheData = function() {
    DataService.getData().then(function(v) {
      // console.log(v);
      daytypes = v.daytypes;
      departures = v.departures;
      directions = v.directions;
      lines = v.lines;
      routes = v.routes;
      signs = v.signs;
      stops = v.stops;
    }, function(e) {
      console.log(e);
    });
  };
})

.controller('AppCtrl', function($rootScope, $scope, $ionicModal, $timeout, DataService) {
  
})

.controller('LinesCtrl', function($rootScope, $scope, $ionicModal, $timeout) {
  $scope.search = "";
  //TODO get lines from JSON line: SERVICE!!
  $scope.lines = lines;
  // $scope.lines = getLines();
})

.controller('StopsCtrl', function($rootScope, $scope, $ionicModal, $timeout) {
  $scope.search = "";
  //TODO get stops from JSON line: SERVICE!!
  $scope.stops = getStops();
})

.controller('DirectionsCtrl', function($rootScope, $scope, $ionicModal, $timeout, $stateParams) {
  $scope.search = "";
  $scope.line = $stateParams.line;

  var out = [];
  getDirectionsForLine($scope.line).forEach(function(d) {
    out.push({
      name: d.dir_name,
      dir_no: d.dir_no,
      stops: getStopsForDirection($scope.line,d.dir_no)
    })
  });
  // console.log(out);
  $scope.directions = out;
})

.controller('DeparturesCtrl',  function($rootScope, $scope, $ionicModal, $timeout, $stateParams){
  $scope.line = $stateParams.line;
  $scope.dir_no = $stateParams.dir_no;
  $scope.stop_id = $stateParams.stop_id;
  $scope.stopName = getStopName($scope.stop_id);
  $scope.dir_name = getDirectionsForLine($scope.line)[$scope.dir_no-1]["dir_name"];
  $scope.days = DAYS;

  $scope.compareTimes = compareTimes;
  $scope.countDataInDepartures = countDataInDepartures;

  var tmpDate = new Date();
  $scope.currentTime = tmpDate.getHours()+":"+tmpDate.getMinutes();
  $scope.nextHour = (tmpDate.getHours()+1)+":"+tmpDate.getMinutes();

  var signs_temp = [];
  var signs_temp1 = [];
  var departures_temp = [];
  var hrs = getHoursInDepartures($scope.line,$scope.dir_no,$scope.stop_id);

  DAYS.forEach(function(d,i) {
    var dhTmp = [];
    hrs.forEach(function(h,j) {
      var dTmp = getDeparturesForHour($scope.line,$scope.dir_no,$scope.stop_id,h,i+1);
      dTmp.forEach(function(f) {
        if(f.signs.length)
          signs_temp.push(f.signs);
      });
      dhTmp.push(dTmp);
    });
    departures_temp.push(dhTmp);
  });
  signs_temp.forEach(function(d) {
    d.split("").forEach(function(e) {
      signs_temp1.push(e);
    });
  });
  signs_temp1 = signs_temp1.filter(function(v,i,s) {return s.indexOf(v) ===i});

  $scope.hours = hrs;
  $scope.departures = departures_temp;
  $scope.signs = getSignsOnlyNeeded($scope.line,$scope.dir_no,signs_temp1);
  $scope.stops = getStopsForDirection($scope.line,$scope.dir_no);

  console.log($scope.departures);
});

