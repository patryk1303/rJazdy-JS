angular.module('starter.directives', [])

.directive('stopName', function(){
	// Runs during compile
	return {
		// name: '',
		// priority: 1,
		// terminal: true,
		scope: {data: '=data'}, // {} = isolate, true = child, false/undefined = no change
		// controller: function($scope, $element, $attrs, $transclude) {},
		// require: 'ngModel', // Array = multiple requires, ? = optional, ^ = check parent elements
		restrict: 'E', // E = Element, A = Attribute, C = Class, M = Comment
		template: '<i ng-show="data.onReq==1" class="assertive fa fa-hand-o-up"></i> <span>{{data.name1}}</span><span ng-show="data.name2"> / {{data.name2}}</span>',
		// templateUrl: '',
		replace: false
		// transclude: true,
		// compile: function(tElement, tAttrs, function transclude(function(scope, cloneLinkingFn){ return function linking(scope, elm, attrs){}})),
	};
})

.directive('accordion', function(){
	// Runs during compile
	return {
		controller: function() {
			var expanders = [];
			this.gotOpened = function(selectedExpander) {
				angular.forEach(expanders,function(expander) {
					if(selectedExpander!=expander) {
						expander.showMe = false;
					}
				});
			};

			this.addExpander = function(expander) {
				expanders.push(expander);
			};
		},
		restrict: 'E', // E = Element, A = Attribute, C = Class, M = Comment
		template: '<div class="accordion" ng-transclude></div>',
		replace: false,
		transclude: true
	};
})

.directive('expander', function(){
	return {
		restrict: "E",
		replace: true,
		transclude: true,
		require: '^accordion',
		scope: {title:'@expanderTitle'},
		templateUrl: 'templates/expander.html',
		link: function(scope,element,attrs,accordionController) {
			scope.showMe = false;
			accordionController.addExpander(scope);

			scope.toggle = function toggle() {
				scope.showMe = !scope.showMe;
				accordionController.gotOpened(scope);
			}
		}
	};
});