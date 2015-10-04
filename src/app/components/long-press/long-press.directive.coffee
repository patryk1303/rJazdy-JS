# https://gist.github.com/BobNisco/9885852

angular.module 'tTableApp'
  .directive 'onLongPress', ['$timeout', ($timeout) ->
    linkFn = ($scope,el,attr) ->

      longPressStartFn = (e) ->
        timeoutFn = ->
          e.preventDefault()
          e.stopPropagation()
          if $scope.longPress
            $scope.$apply ->
              e.preventDefault()
              e.stopPropagation()
              $scope.$eval attr.onLongPress
              return
          return

        $scope.longPress = yes

        $timeout timeoutFn, 600
        return

      longPressEndFn = (e) ->
        $scope.longPress = no

        if attr.onTouchEnd
          $scope.apply ->
            $scope.$eval attr.onTouchEnd
            return
        return

      el.bind 'touchstart', longPressStartFn
      el.bind 'mousedown', longPressStartFn
      el.bind 'touchend', longPressEndFn
      el.bind 'mouseup', longPressEndFn
        
    directive =
      link: linkFn
  ]