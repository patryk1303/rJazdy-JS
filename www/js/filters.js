angular.module('starter.filters',[])

.filter('polishFilter', function() {
	return function(input, search) {
		try {
			var output = input.filter(function(element) {
				var name = element.name1;
					name += element.name2 !="" ? " / " + element.name2:"";
				return checkPolishStrings(name,search);
			});
			return output;
		}
		catch(e) {
			return null;
		}
	};
});