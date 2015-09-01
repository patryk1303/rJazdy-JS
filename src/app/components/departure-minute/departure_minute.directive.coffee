angular.module 'tTableApp'
  .directive 'departureMinute', ->
    directive =
      restrict: 'EA'
      replace: false
      scope: dep: '=departure', signs: '=signs', hours: '=', moment: '='
      templateUrl: 'app/components/departure-minute/departure-minute.html' 
      link: (scope, el, attrs, controller) ->
        tmpDate = new Date()
        currentDeparture = scope.dep.hour + ':' + scope.dep.min
        currentTime = tmpDate.getHours()+ ':' +tmpDate.getMinutes()
        nextHour = (tmpDate.getHours()+1)+ ':' +tmpDate.getMinutes()

        # if `attrs.moment == true`
        #   el.html(moment(currentDeparture,'HH:mm').fromNow())

        if checkTimes currentDeparture,currentTime,nextHour
          el.addClass 'next_h'
        else if checkTimes currentDeparture,'00:00',currentTime
          el.addClass 'passed_h'

        if not attrs.signs
          attrs.signs = yes
        return