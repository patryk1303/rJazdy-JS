angular.module('starter.services', [])

.factory('DataService', ['$http','$q','$rootScope', function($http,$q,$rootScope) {
	return {
		getData: function() {
			var delay = $q.defer();
			var data = {};
			var sDaytypes = $http.get('timetable/daytypes.json',{cache:true});
			var sDepartures = $http.get('timetable/departures.json',{cache:true});
			var sDirections = $http.get('timetable//directions.json',{cache:true});
			var sLines = $http.get('timetable//lines.json',{cache:true});
			var sRoutes = $http.get('timetable/routes.json',{cache:true});
			var sSigns = $http.get('timetable/signs.json',{cache:true});
			var sStops = $http.get('timetable/stops.json',{cache:true});

			var arrQ = [sDaytypes,sDepartures,sDirections,sLines,sRoutes,sSigns,sStops];
			$q.all(arrQ).then(function(values,h) {
				// console.log(values);
				data.daytypes = values[0].data;
				data.departures = values[1].data;
				data.directions = values[2].data;
				data.lines = values[3].data;
				data.routes = values[4].data;
				data.signs = values[5].data;
				data.stops = values[6].data;
				delay.resolve(data);
			},function(e) {
				console.error(e);
				delay.reject(e);
			});
			return delay.promise;
		}
	}
}]);