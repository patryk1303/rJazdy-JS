angular.module "tTableApp"
  .run ['$log', ($log) ->
    $log.debug 'runBlock end'
  ]